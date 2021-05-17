create or replace
function jmr_freeze_header_column (
    p_dynamic_action in apex_plugin.t_dynamic_action
  , p_plugin         in apex_plugin.t_plugin
)
return apex_plugin.t_dynamic_action_render_result
is
  l_result apex_plugin.t_dynamic_action_render_result;

  l_attr_nro_columns        number      := p_dynamic_action.attribute_01;
  l_attr_border_header_yn   varchar2(1) := p_dynamic_action.attribute_02;
  l_attr_border_columns_yn  varchar2(1) := p_dynamic_action.attribute_03;
  l_attr_custom_height      varchar2(100) := '700px';
  l_attr_bg_color           varchar2(20)  := '#FFFFF';
  l_crlf                    char(2) := chr(13)||chr(10);

begin

  l_result.attribute_01        := l_attr_nro_columns;
  l_result.attribute_02        := l_attr_border_header_yn;
  l_result.attribute_03        := l_attr_border_columns_yn;

  l_result.javascript_function := '
    function(){
      insumTk.freezer.coolReport(this.triggeringElement,' || '{'
      || l_crlf ||  apex_javascript.add_attribute(p_name      => 'nro_columns'
                                                , p_value     => l_attr_nro_columns
                                                , p_add_comma => TRUE)
      || l_crlf ||  apex_javascript.add_attribute(p_name      => 'border_header_yn'
                                                , p_value     => l_attr_border_header_yn
                                                , p_add_comma => TRUE)
      || l_crlf ||  apex_javascript.add_attribute(p_name      => 'border_columns_yn'
                                                , p_value     => l_attr_border_columns_yn
                                                , p_add_comma => FALSE)
      || '}' ||
      '
      );
    }';

    -- Set the size for ALL applicable regions after the window is resized
    -- the "p_key" param ensures that only one instance of this code is injected
    -- into the page. That's because `frozenReportSel` will find all the reports
    -- on the page with frozen col and head
    -- Warning: If this is called before the reports have been frozen they may not be found
    apex_javascript.add_onload_code(
      '$(window).resize(function() {$(insumTk.freezer.frozenReportSel()).each(function(){insumTk.freezer.setWidth(this);});});'
      , p_key => 'jmr.insumTk.freezer'
    );

  if apex_application.g_debug then

    apex_plugin_util.debug_dynamic_action (
      p_plugin         => p_plugin,
      p_dynamic_action => p_dynamic_action
    );

  end if;

  return l_result;

end jmr_freeze_header_column;
/