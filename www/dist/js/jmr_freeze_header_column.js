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
      C_MAGIC_PADDING = 20; // 10 (10 * 2) is our magic padding number

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



  /**
   * Freeze the first column and the headers of a Classic Report
   * and start listening for scroll event in order to maintain the frozen column
   * and the headers scrolling in sync
   *
   * @issues
   *  - If you resize the browser by making it larger, the header may fit, but the body may extend.
   *    A possible fix is to re-run the sizes code on head/body after resize.
   *    However, the workaround is to simply reload the page.
   * 
   * @param  {Strig|DOM Element} region
   *
   * @function coolReport
   * @memberOf insumTk.freezer
   */
  freezer.coolReport = function (region) {
    var $el=$(region),
        $thead=$el.find(C_TABLE_HEAD),
        $tbody=$el.find(C_TABLE_BODY),
        m=0;

    // flag this report with our "Template Option"
    $el.addClass(C_FREEZE_TPL_OPTION);

    /*
     Set the widths to match the container region.
     This is needed so the scrollLeft values make sense
    */
    insumTk.freezer.setWidth(region);


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
    $tbody.scroll(function(e) { //detect a scroll event on the tbody
      /*
      Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
      of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain
      it's relative position at the left of the table.    
      */
      $thead.css("left", -$tbody.scrollLeft()); //fix the thead relative to the body scrolling
      $thead.find('th:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first cell of the header
      $tbody.find('td:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first column of body (this column is "frozen")
    });

  };

})( insumTk.freezer, apex.jQuery );

//# sourceMappingURL=jmr_freeze_header_column.js.map
