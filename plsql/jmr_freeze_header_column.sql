create or replace
function jmr_freeze_header_column (
    p_dynamic_action in apex_plugin.t_dynamic_action
  , p_plugin         in apex_plugin.t_plugin 
) 
return apex_plugin.t_dynamic_action_render_result
is
  l_result apex_plugin.t_dynamic_action_render_result;

  l_attr_default_height_ind varchar2(1)   := p_dynamic_action.attribute_01;
  l_attr_custom_height      varchar2(100) := p_dynamic_action.attribute_02;
  l_attr_bg_color           varchar2(20)  := nvl(p_dynamic_action.attribute_03, '#FFFFF');

begin

  l_result.attribute_02        := nvl(l_attr_custom_height, '700px');
  l_result.attribute_03        := l_attr_bg_color;

  l_result.javascript_function := '
    function(){
      insumTk.freezer.coolReport(this.triggeringElement);
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