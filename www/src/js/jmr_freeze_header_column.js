/**
 * Main namespace insum toolit.
 *
 * @namespace
 */
var insumTk = insumTk || {};

insumTk.freezer = {};

(function( freezer, $ ) {
    "use strict";


  var C_FREEZE_TPL_OPTION = "jsInsumFreezeColHead",
      SEL_FROZEN_REPORTS = "." + C_FREEZE_TPL_OPTION,
      C_TABLE_HEAD = "table.t-Report-report thead",
      C_TABLE_BODY = "table.t-Report-report tbody",
      C_MAGIC_PADDING = 20, // 10 (10 * 2) is our magic padding number
      HEIGHT_PIXELS = 500;

  freezer.frozenReportSel = function () {
    return SEL_FROZEN_REPORTS;
  };

  /**
   * Set the report width to match that of the container region (region)
   *
   * @param  {Strig|DOM Element} region
   *
   * @function setWidth
   * @memberOf insumTk.freezer
   */
  freezer.setWidth = function (region) {

    var $el=$(region),
        $thead=$el.find(C_TABLE_HEAD),
        $tbody=$el.find(C_TABLE_BODY),
        newWidth=$el.width() - C_MAGIC_PADDING; 

    /*
     Set the widths to match the container region.
     This is needed so the scrollLeft values make sense
    */
    $thead.width(newWidth);
    $tbody.width(newWidth);
  };

    // Set the IR ro a custom height
    // To use add the class "ci-hWin" to an IR region class to force the heigh
    // to the viewport
    // AND set "Fix Headings" to "Page"
    // 
    // ci means custom height and the "i" is the normal prefix in UT for fixed height values
    // hWin means Window Height
    freezer.setIRHeightToViewport = function () {

        // Add the class "ci-hWin" to an IR region to force the heigh to the viewport
        var $report = apex.jQuery(".ci-hWin");

        // only if a single IR has the trigger class
        if ($report.length == 1) {
            apex.debug.message(4, "Set fix IR listeners on IR:", $report);

            // this one is on "Afer Refresh" of the report because the previous height will be lost
            apex.jQuery($report).on('apexafterrefresh', insumTk.freezer._fixIRHeight);

            // this one is whenever the window is refreshed
            // AND Kick off one resize to fix height after page load
            apex.jQuery(window).on('apexwindowresized', insumTk.freezer._fixIRHeight).resize();
        }


    },

  freezer._fixIRHeight = function(ev) {
      var $report = apex.jQuery(".ci-hWin"),
          $reportEl = $report.find("table.t-Report-report tbody"),
          toolBar = $report.find(".a-IRR-controls").height(),
          bodyTitle = apex.jQuery(".t-Body-title").height(),
          tHeader = apex.jQuery(".t-Header").height(),
          // Magic numbers:
          //   160 will maximize the number of rows but show a double scrollbar
          //   260 eliminates the double scrollbar, but will waste a lot of space
          cHeight = HEIGHT_PIXELS;

      apex.debug.message(4, ev);
      apex.debug.message(4, "Fixing IR to a height of " + cHeight);

      // https://stackoverflow.com/questions/1248081/get-the-browser-viewport-dimensions-with-javascript
      var viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0),
          newHeight = viewHeight - tHeader - cHeight;
// newHeight = viewHeight - bodyTitle - tHeader - toolBar - cHeight;


      // Resize the report container
      console.log({newHeight});
      $reportEl.height(newHeight);

    },



  /**
   * Freeze the first column and the headers of a Classic Report
   * and start listening for scroll event in order to maintain the frozen column
   * and the headers scrolling in sync
   *
   * @issues
   *  - If you resize the browser by making it larger, the header may fit, but the body may extend.
   *    A possible fix is to re-run the sizes to head/body after resize.
   *    However, the workaround is to simply reload the page.
   * 
   * @param  {Strig|DOM Element} region
   *
   * @function coolReport
   * @memberOf insumTk.freezer
   */
  freezer.coolReport = function (region, options) {
    var $el=$(region),
        $thead=$el.find(C_TABLE_HEAD),
        $tbody=$el.find(C_TABLE_BODY),
        m=0;

    let autoHeight = options.mode == "auto";
    let heightPixels = options.height || 500;
    HEIGHT_PIXELS = heightPixels;

    // flag this report with our "Template Option"
    $el.addClass(C_FREEZE_TPL_OPTION);


// .jsInsumFreezeColHead table.t-Report-report tbody 

    if (autoHeight) {
      insumTk.freezer.setIRHeightToViewport(region);
    }

    /*
     Set the widths to match the container region.
     This is needed so the scrollLeft values make sense
    */
    insumTk.freezer.setWidth(region);
    

    /* 
     *  Clone the very first row and empty it.
     *  This row will receive the matching sizing in the step
     */
    var firstRow = $tbody.find( 'tr' )[0];
    $( firstRow ).clone().insertAfter( firstRow );  // the clone is now row 2 
    $(firstRow).find("td").removeClass().html("");  // back on row 1 empty it all out


    // Match the header column height, against the next column (which should be sized to the table content)
    $thead.find("th:first-child").each(function(i){
      $(this).css('height',$(this).next().outerHeight());
    });

    // Match the first column height to the next column (which should be sized to the table content)
    // the first column doesn't know the height of the table cells
    $tbody.find("tr>td:nth-child(1)").each(function(i){
      $(this).css('height',$(this).next().outerHeight());
    });

    // Match the header width to the the TD of the first TR (which should be sized to the table content)
    $thead.find("th").each(function(i){
      var thw=$(this).outerWidth(),
          tdw=$tbody.find("tr:first>td:nth-child("+(i+1)+")").outerWidth(),
          w=thw>tdw?thw:tdw; // find the large size between th and td

      // Make both match
      $(this).css({'min-width':w,'max-width':w});
      $tbody.find("tr:first>td:nth-child("+(i+1)+")").css({'min-width':w,'max-width':w});

    });


    /* 
     Based on https://jsfiddle.net/RMarsh/bzuasLcz/3/
    */
    function handleScroll() { //detect a scroll event on the tbody
      /*
      Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
      of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain
      it's relative position at the left of the table.    
      */
      $thead.css("left", -$tbody.scrollLeft()); //fix the thead relative to the body scrolling
      $thead.find('th:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first cell of the header
      $tbody.find('td:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first column of body (this column is "frozen")
    }

    $tbody.scroll(apex.util.debounce(handleScroll, 30));

  };

})( insumTk.freezer, apex.jQuery );

//# sourceMappingURL=jmr_freeze_header_column.js.map
