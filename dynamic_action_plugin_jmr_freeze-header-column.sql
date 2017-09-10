set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.4.00.12'
,p_default_workspace_id=>260653474592536364
,p_default_application_id=>187
,p_default_owner=>'INSUM'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/jmr_freeze_header_column
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(367061745204508505)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'JMR.FREEZE-HEADER-COLUMN'
,p_display_name=>'Insum Freeze Headers & Column'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>'#PLUGIN_FILES#jmr_freeze_header_column#MIN#.js'
,p_css_file_urls=>'#PLUGIN_FILES#jmr_freeze_header_column#MIN#.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function jmr_freeze_header_column (',
'    p_dynamic_action in apex_plugin.t_dynamic_action',
'  , p_plugin         in apex_plugin.t_plugin ',
') ',
'return apex_plugin.t_dynamic_action_render_result',
'is',
'  l_result apex_plugin.t_dynamic_action_render_result;',
'',
'  l_attr_default_height_ind varchar2(1)   := p_dynamic_action.attribute_01;',
'  l_attr_custom_height      varchar2(100) := p_dynamic_action.attribute_02;',
'  l_attr_bg_color           varchar2(20)  := nvl(p_dynamic_action.attribute_03, ''#FFFFF'');',
'',
'begin',
'',
'  l_result.attribute_02        := nvl(l_attr_custom_height, ''700px'');',
'  l_result.attribute_03        := l_attr_bg_color;',
'',
'  l_result.javascript_function := ''',
'    function(){',
'      insumTk.freezer.coolReport(this.triggeringElement);',
'    }'';',
'',
'    -- Set the size for ALL applicable regions after the window is resized',
'    -- the "p_key" param ensures that only one instance of this code is injected',
'    -- into the page. That''s because `frozenReportSel` will find all the reports',
'    -- on the page with frozen col and head',
'    -- Warning: If this is called before the reports have been frozen they may not be found',
'    apex_javascript.add_onload_code(',
'      ''$(window).resize(function() {$(insumTk.freezer.frozenReportSel()).each(function(){insumTk.freezer.setWidth(this);});});''',
'      , p_key => ''jmr.insumTk.freezer''',
'    );',
'',
'  if apex_application.g_debug then',
'',
'    apex_plugin_util.debug_dynamic_action (',
'      p_plugin         => p_plugin,',
'      p_dynamic_action => p_dynamic_action',
'    );',
'',
'  end if;',
'',
'  return l_result;',
'',
'end jmr_freeze_header_column;'))
,p_render_function=>'jmr_freeze_header_column'
,p_standard_attributes=>'REGION:JQUERY_SELECTOR:JAVASCRIPT_EXPRESSION:TRIGGERING_ELEMENT'
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'This plugin will freeze the first column and the headers of a Classic Report.',
'',
'How To use:',
'1. Create an "After Refresh" Dynamic Action on the Classic Report you want to "freeze".',
'2. For the True Action select "Insum Freeze Headers & Column"',
'3. Make sure "Fire on Initialization" is Yes.',
'4. Don''t specify an affected element, the plugin uses `this.triggeringElement`'))
,p_version_identifier=>'1.0.0'
,p_about_url=>'http://rimblas.com/blog/'
,p_files_version=>5
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72747B706F736974696F6E3A72656C61746976653B6F766572666C6F773A68696464656E3B626F726465722D636F6C6C617073653A636F6C6C6170';
wwv_flow_api.g_varchar2_table(2) := '73657D2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074686561647B706F736974696F6E3A72656C61746976653B646973706C61793A626C6F636B3B6F766572666C6F773A76697369626C';
wwv_flow_api.g_varchar2_table(3) := '657D2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074686561642074727B626F726465722D626F74746F6D3A32707820736F6C6964207267626128302C302C302C2E35297D2E6A73496E73';
wwv_flow_api.g_varchar2_table(4) := '756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074686561642074683A66697273742D6368696C647B706F736974696F6E3A72656C61746976653B646973706C61793A626C6F636B3B6261636B67726F756E';
wwv_flow_api.g_varchar2_table(5) := '642D636F6C6F723A236666663B626F726465722D72696768743A31707820736F6C6964207267626128302C302C302C2E35297D2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074626F6479';
wwv_flow_api.g_varchar2_table(6) := '7B706F736974696F6E3A72656C61746976653B646973706C61793A626C6F636B3B6865696768743A35303070783B6F766572666C6F773A7363726F6C6C7D2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D72';
wwv_flow_api.g_varchar2_table(7) := '65706F72742074626F64792074722074643A66697273742D6368696C647B706F736974696F6E3A72656C61746976653B646973706C61793A626C6F636B3B626F726465722D72696768743A31707820736F6C6964207267626128302C302C302C2E35297D';
wwv_flow_api.g_varchar2_table(8) := '2E6A73496E73756D467265657A65436F6C48656164202E742D5265706F72742D2D616C74526F777344656661756C74202E742D5265706F72742D7265706F72742074723A6E74682D6368696C6428326E29202E742D5265706F72742D63656C6C7B626163';
wwv_flow_api.g_varchar2_table(9) := '6B67726F756E642D636F6C6F723A236666667D0A2F2A2320736F757263654D617070696E6755524C3D6A6D725F667265657A655F6865616465725F636F6C756D6E2E6D696E2E6373732E6D6170202A2F0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(367121876124860533)
,p_plugin_id=>wwv_flow_api.id(367061745204508505)
,p_file_name=>'jmr_freeze_header_column.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A0A424547494E202D20537469636B79204865616465727320616E6420436F6C756D6E730A4261736564206F6E2068747470733A2F2F6A73666964646C652E6E65742F524D617273682F627A7561734C637A2F332F0A2A2F0A2E6A73496E73756D4672';
wwv_flow_api.g_varchar2_table(2) := '65657A65436F6C48656164207461626C652E742D5265706F72742D7265706F7274207B0A2020706F736974696F6E3A2072656C61746976653B0A20202F2A77696474683A2037303070783B2A2F0A20206F766572666C6F773A2068696464656E3B0A2020';
wwv_flow_api.g_varchar2_table(3) := '626F726465722D636F6C6C617073653A20636F6C6C617073653B0A7D0A0A0A2F2A74686561642A2F0A2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F7274207468656164207B0A2020706F736974';
wwv_flow_api.g_varchar2_table(4) := '696F6E3A2072656C61746976653B0A2020646973706C61793A20626C6F636B3B202F2A73657065726174657320746865206865616465722066726F6D2074686520626F647920616C6C6F77696E6720697420746F20626520706F736974696F6E65642A2F';
wwv_flow_api.g_varchar2_table(5) := '0A20206F766572666C6F773A2076697369626C653B0A20202F2A77696474683A2037303070783B2073657420776964746820746F2074686520636F6E7461696E657220726567696F6E20766961204A53202A2F0A7D0A0A2F2A2068656164657220736861';
wwv_flow_api.g_varchar2_table(6) := '646F77202A2F0A2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F7274207468656164207472207B0A2020626F726465722D626F74746F6D3A2032707820736F6C6964207267626128302C20302C20';
wwv_flow_api.g_varchar2_table(7) := '302C202E35293B0A7D0A0A0A0A2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074686561642074683A6E74682D6368696C64283129207B2F2A66697273742063656C6C20696E2074686520';
wwv_flow_api.g_varchar2_table(8) := '6865616465722A2F0A2020706F736974696F6E3A2072656C61746976653B0A2020646973706C61793A20626C6F636B3B202F2A736570657261746573207468652066697273742063656C6C20696E20746865206865616465722066726F6D207468652068';
wwv_flow_api.g_varchar2_table(9) := '65616465722A2F0A20206261636B67726F756E642D636F6C6F723A20236666666666663B20202F2A2073746F70207468652066726F7A656E20636F6C206F6E206576656E20726F77732066726F6D206265696E67207472616E73706172656E74202A2F0A';
wwv_flow_api.g_varchar2_table(10) := '2020626F726465722D72696768743A2031707820736F6C6964207267626128302C20302C20302C202E35293B0A7D0A0A0A2F2A74626F64792A2F0A2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F';
wwv_flow_api.g_varchar2_table(11) := '72742074626F6479207B0A2020706F736974696F6E3A2072656C61746976653B0A2020646973706C61793A20626C6F636B3B202F2A736570657261746573207468652074626F64792066726F6D20746865206865616465722A2F0A20206865696768743A';
wwv_flow_api.g_varchar2_table(12) := '2035303070783B20202F2A636F6E73696465722073657474696E672068656967687420746F2074686520636F6E7461696E657220726567696F6E20766961204A532A2F0A20206F766572666C6F773A207363726F6C6C3B0A202F2A77696474683A203730';
wwv_flow_api.g_varchar2_table(13) := '3070783B2073657420776964746820746F2074686520636F6E7461696E657220726567696F6E20766961204A53202A2F0A7D0A0A0A2E6A73496E73756D467265657A65436F6C48656164207461626C652E742D5265706F72742D7265706F72742074626F';
wwv_flow_api.g_varchar2_table(14) := '64792074722074643A6E74682D6368696C64283129207B20202F2A7468652066697273742063656C6C20696E20656163682074722A2F0A2020706F736974696F6E3A2072656C61746976653B0A2020646973706C61793A20626C6F636B3B202F2A736570';
wwv_flow_api.g_varchar2_table(15) := '6572617465732074686520666972737420636F6C756D6E2066726F6D207468652074626F64792A2F0A2020626F726465722D72696768743A2031707820736F6C6964207267626128302C20302C20302C202E35293B0A7D0A0A2E6A73496E73756D467265';
wwv_flow_api.g_varchar2_table(16) := '657A65436F6C48656164202E742D5265706F72742D2D616C74526F777344656661756C74202E742D5265706F72742D7265706F72742074723A6E74682D6368696C64286576656E29202E742D5265706F72742D63656C6C207B0A20206261636B67726F75';
wwv_flow_api.g_varchar2_table(17) := '6E642D636F6C6F723A20236666666666663B20202F2A2073746F70207468652066726F7A656E20636F6C206F6E206576656E20726F77732066726F6D206265696E67207472616E73706172656E74202A2F0A7D0A0A2F2A0A454E44202D20537469636B79';
wwv_flow_api.g_varchar2_table(18) := '204865616465727320616E6420436F6C756D6E730A2A2F0A2F2A2320736F757263654D617070696E6755524C3D6A6D725F667265657A655F6865616465725F636F6C756D6E2E6373732E6D6170202A2F0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(367122283077861849)
,p_plugin_id=>wwv_flow_api.id(367061745204508505)
,p_file_name=>'jmr_freeze_header_column.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0A202A204D61696E206E616D65737061636520696E73756D20746F6F6C69742E0A202A0A202A20406E616D6573706163650A202A2F0A76617220696E73756D546B3D696E73756D546B7C7C7B7D3B696E73756D546B2E667265657A65723D7B7D2C';
wwv_flow_api.g_varchar2_table(2) := '66756E6374696F6E28742C65297B2275736520737472696374223B742E66726F7A656E5265706F727453656C3D66756E6374696F6E28297B72657475726E222E6A73496E73756D467265657A65436F6C48656164227D2C742E73657457696474683D6675';
wwv_flow_api.g_varchar2_table(3) := '6E6374696F6E2874297B76617220693D652874292C6E3D692E66696E6428227461626C652E742D5265706F72742D7265706F727420746865616422292C723D692E66696E6428227461626C652E742D5265706F72742D7265706F72742074626F64792229';
wwv_flow_api.g_varchar2_table(4) := '2C683D692E776964746828292D32303B6E2E77696474682868292C722E77696474682868297D2C742E636F6F6C5265706F72743D66756E6374696F6E2874297B76617220693D652874292C6E3D692E66696E6428227461626C652E742D5265706F72742D';
wwv_flow_api.g_varchar2_table(5) := '7265706F727420746865616422292C723D692E66696E6428227461626C652E742D5265706F72742D7265706F72742074626F647922293B692E616464436C61737328226A73496E73756D467265657A65436F6C4865616422292C696E73756D546B2E6672';
wwv_flow_api.g_varchar2_table(6) := '65657A65722E73657457696474682874292C6E2E66696E64282274683A66697273742D6368696C6422292E656163682866756E6374696F6E2874297B652874686973292E6373732822686569676874222C652874686973292E6E65787428292E6F757465';
wwv_flow_api.g_varchar2_table(7) := '724865696768742829297D292C722E66696E64282274723E74643A6E74682D6368696C6428312922292E656163682866756E6374696F6E2874297B652874686973292E6373732822686569676874222C652874686973292E6E65787428292E6F75746572';
wwv_flow_api.g_varchar2_table(8) := '4865696768742829297D292C6E2E66696E642822746822292E656163682866756E6374696F6E2874297B76617220693D652874686973292E6F75746572576964746828292C6E3D722E66696E64282274723A66697273743E74643A6E74682D6368696C64';
wwv_flow_api.g_varchar2_table(9) := '28222B28742B31292B222922292E6F75746572576964746828292C683D693E6E3F693A6E3B652874686973292E637373287B226D696E2D7769647468223A682C226D61782D7769647468223A687D292C722E66696E64282274723A66697273743E74643A';
wwv_flow_api.g_varchar2_table(10) := '6E74682D6368696C6428222B28742B31292B222922292E637373287B226D696E2D7769647468223A682C226D61782D7769647468223A687D297D292C722E7363726F6C6C2866756E6374696F6E2874297B6E2E63737328226C656674222C2D722E736372';
wwv_flow_api.g_varchar2_table(11) := '6F6C6C4C6566742829292C6E2E66696E64282274683A6E74682D6368696C6428312922292E63737328226C656674222C722E7363726F6C6C4C6566742829292C722E66696E64282274643A6E74682D6368696C6428312922292E63737328226C65667422';
wwv_flow_api.g_varchar2_table(12) := '2C722E7363726F6C6C4C6566742829297D297D7D28696E73756D546B2E667265657A65722C617065782E6A5175657279293B0A2F2F2320736F757263654D617070696E6755524C3D6A6D725F667265657A655F6865616465725F636F6C756D6E2E6D696E';
wwv_flow_api.g_varchar2_table(13) := '2E6A732E6D61700A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(367122614905863780)
,p_plugin_id=>wwv_flow_api.id(367061745204508505)
,p_file_name=>'jmr_freeze_header_column.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0A202A204D61696E206E616D65737061636520696E73756D20746F6F6C69742E0A202A0A202A20406E616D6573706163650A202A2F0A76617220696E73756D546B203D20696E73756D546B207C7C207B7D3B0A0A696E73756D546B2E667265657A';
wwv_flow_api.g_varchar2_table(2) := '6572203D207B7D3B0A0A2866756E6374696F6E2820667265657A65722C20242029207B0A202020202275736520737472696374223B0A0A0A202076617220435F465245455A455F54504C5F4F5054494F4E203D20226A73496E73756D467265657A65436F';
wwv_flow_api.g_varchar2_table(3) := '6C48656164222C0A20202020202053454C5F46524F5A454E5F5245504F525453203D20222E22202B20435F465245455A455F54504C5F4F5054494F4E2C0A202020202020435F5441424C455F48454144203D20227461626C652E742D5265706F72742D72';
wwv_flow_api.g_varchar2_table(4) := '65706F7274207468656164222C0A202020202020435F5441424C455F424F4459203D20227461626C652E742D5265706F72742D7265706F72742074626F6479222C0A202020202020435F4D414749435F50414444494E47203D2032303B202F2F20313020';
wwv_flow_api.g_varchar2_table(5) := '283130202A203229206973206F7572206D616769632070616464696E67206E756D6265720A0A2020667265657A65722E66726F7A656E5265706F727453656C203D2066756E6374696F6E202829207B0A2020202072657475726E2053454C5F46524F5A45';
wwv_flow_api.g_varchar2_table(6) := '4E5F5245504F5254533B0A20207D3B0A0A20202F2A2A0A2020202A2053657420746865207265706F727420776964746820746F206D617463682074686174206F662074686520636F6E7461696E657220726567696F6E2028726567696F6E290A2020202A';
wwv_flow_api.g_varchar2_table(7) := '0A2020202A2040706172616D20207B53747269677C444F4D20456C656D656E747D20726567696F6E0A2020202A0A2020202A204066756E6374696F6E2073657457696474680A2020202A20406D656D6265724F6620696E73756D546B2E667265657A6572';
wwv_flow_api.g_varchar2_table(8) := '0A2020202A2F0A2020667265657A65722E7365745769647468203D2066756E6374696F6E2028726567696F6E29207B0A0A202020207661722024656C3D2428726567696F6E292C0A20202020202020202474686561643D24656C2E66696E6428435F5441';
wwv_flow_api.g_varchar2_table(9) := '424C455F48454144292C0A20202020202020202474626F64793D24656C2E66696E6428435F5441424C455F424F4459292C0A20202020202020206E657757696474683D24656C2E77696474682829202D20435F4D414749435F50414444494E473B200A0A';
wwv_flow_api.g_varchar2_table(10) := '202020202F2A0A2020202020536574207468652077696474687320746F206D617463682074686520636F6E7461696E657220726567696F6E2E0A202020202054686973206973206E656564656420736F20746865207363726F6C6C4C6566742076616C75';
wwv_flow_api.g_varchar2_table(11) := '6573206D616B652073656E73650A202020202A2F0A202020202474686561642E7769647468286E65775769647468293B0A202020202474626F64792E7769647468286E65775769647468293B0A20207D3B0A0A0A0A20202F2A2A0A2020202A2046726565';
wwv_flow_api.g_varchar2_table(12) := '7A652074686520666972737420636F6C756D6E20616E64207468652068656164657273206F66206120436C6173736963205265706F72740A2020202A20616E64207374617274206C697374656E696E6720666F72207363726F6C6C206576656E7420696E';
wwv_flow_api.g_varchar2_table(13) := '206F7264657220746F206D61696E7461696E207468652066726F7A656E20636F6C756D6E0A2020202A20616E64207468652068656164657273207363726F6C6C696E6720696E2073796E630A2020202A0A2020202A20406973737565730A2020202A2020';
wwv_flow_api.g_varchar2_table(14) := '2D20496620796F7520726573697A65207468652062726F77736572206279206D616B696E67206974206C61726765722C2074686520686561646572206D6179206669742C206275742074686520626F6479206D617920657874656E642E0A2020202A2020';
wwv_flow_api.g_varchar2_table(15) := '20204120706F737369626C652066697820697320746F2072652D72756E207468652073697A657320746F20686561642F626F647920616674657220726573697A652E0A2020202A20202020486F77657665722C2074686520776F726B61726F756E642069';
wwv_flow_api.g_varchar2_table(16) := '7320746F2073696D706C792072656C6F61642074686520706167652E0A2020202A200A2020202A2040706172616D20207B53747269677C444F4D20456C656D656E747D20726567696F6E0A2020202A0A2020202A204066756E6374696F6E20636F6F6C52';
wwv_flow_api.g_varchar2_table(17) := '65706F72740A2020202A20406D656D6265724F6620696E73756D546B2E667265657A65720A2020202A2F0A2020667265657A65722E636F6F6C5265706F7274203D2066756E6374696F6E2028726567696F6E29207B0A202020207661722024656C3D2428';
wwv_flow_api.g_varchar2_table(18) := '726567696F6E292C0A20202020202020202474686561643D24656C2E66696E6428435F5441424C455F48454144292C0A20202020202020202474626F64793D24656C2E66696E6428435F5441424C455F424F4459292C0A20202020202020206D3D303B0A';
wwv_flow_api.g_varchar2_table(19) := '0A202020202F2F20666C61672074686973207265706F72742077697468206F7572202254656D706C617465204F7074696F6E220A2020202024656C2E616464436C61737328435F465245455A455F54504C5F4F5054494F4E293B0A0A202020202F2A0A20';
wwv_flow_api.g_varchar2_table(20) := '20202020536574207468652077696474687320746F206D617463682074686520636F6E7461696E657220726567696F6E2E0A202020202054686973206973206E656564656420736F20746865207363726F6C6C4C6566742076616C756573206D616B6520';
wwv_flow_api.g_varchar2_table(21) := '73656E73650A202020202A2F0A20202020696E73756D546B2E667265657A65722E736574576964746828726567696F6E293B0A0A0A202020202F2F204D61746368207468652068656164657220636F6C756D6E206865696768742C20616761696E737420';
wwv_flow_api.g_varchar2_table(22) := '746865206E65787420636F6C756D6E202877686963682073686F756C642062652073697A656420746F20746865207461626C6520636F6E74656E74290A202020202474686561642E66696E64282274683A66697273742D6368696C6422292E6561636828';
wwv_flow_api.g_varchar2_table(23) := '66756E6374696F6E2869297B0A202020202020242874686973292E6373732827686569676874272C242874686973292E6E65787428292E6F757465724865696768742829293B0A202020207D293B0A0A202020202F2F204D617463682074686520666972';
wwv_flow_api.g_varchar2_table(24) := '737420636F6C756D6E2068656967687420746F20746865206E65787420636F6C756D6E202877686963682073686F756C642062652073697A656420746F20746865207461626C6520636F6E74656E74290A202020202F2F2074686520666972737420636F';
wwv_flow_api.g_varchar2_table(25) := '6C756D6E20646F65736E2774206B6E6F772074686520686569676874206F6620746865207461626C652063656C6C730A202020202474626F64792E66696E64282274723E74643A6E74682D6368696C6428312922292E656163682866756E6374696F6E28';
wwv_flow_api.g_varchar2_table(26) := '69297B0A202020202020242874686973292E6373732827686569676874272C242874686973292E6E65787428292E6F757465724865696768742829293B0A202020207D293B0A0A202020202F2F204D617463682074686520686561646572207769647468';
wwv_flow_api.g_varchar2_table(27) := '20746F2074686520746865205444206F6620746865206669727374205452202877686963682073686F756C642062652073697A656420746F20746865207461626C6520636F6E74656E74290A202020202474686561642E66696E642822746822292E6561';
wwv_flow_api.g_varchar2_table(28) := '63682866756E6374696F6E2869297B0A202020202020766172207468773D242874686973292E6F75746572576964746828292C0A202020202020202020207464773D2474626F64792E66696E64282274723A66697273743E74643A6E74682D6368696C64';
wwv_flow_api.g_varchar2_table(29) := '28222B28692B31292B222922292E6F75746572576964746828292C0A20202020202020202020773D7468773E7464773F7468773A7464773B202F2F2066696E6420746865206C617267652073697A65206265747765656E20746820616E642074640A0A20';
wwv_flow_api.g_varchar2_table(30) := '20202020202F2F204D616B6520626F7468206D617463680A202020202020242874686973292E637373287B276D696E2D7769647468273A772C276D61782D7769647468273A777D293B0A2020202020202474626F64792E66696E64282274723A66697273';
wwv_flow_api.g_varchar2_table(31) := '743E74643A6E74682D6368696C6428222B28692B31292B222922292E637373287B276D696E2D7769647468273A772C276D61782D7769647468273A777D293B0A0A202020207D293B0A0A0A202020202F2A200A20202020204261736564206F6E20687474';
wwv_flow_api.g_varchar2_table(32) := '70733A2F2F6A73666964646C652E6E65742F524D617273682F627A7561734C637A2F332F0A202020202A2F0A202020202474626F64792E7363726F6C6C2866756E6374696F6E286529207B202F2F6465746563742061207363726F6C6C206576656E7420';
wwv_flow_api.g_varchar2_table(33) := '6F6E207468652074626F64790A2020202020202F2A0A20202020202053657474696E6720746865207468656164206C6566742076616C756520746F20746865206E656761746976652076616C756C65206F662074626F64792E7363726F6C6C4C65667420';
wwv_flow_api.g_varchar2_table(34) := '77696C6C206D616B6520697420747261636B20746865206D6F76656D656E740A2020202020206F66207468652074626F647920656C656D656E742E2053657474696E6720616E20656C656D656E7473206C6566742076616C756520746F2074686174206F';
wwv_flow_api.g_varchar2_table(35) := '66207468652074626F64792E7363726F6C6C4C656674206C656674206D616B6573206974206D61696E7461696E0A202020202020697427732072656C617469766520706F736974696F6E20617420746865206C656674206F6620746865207461626C652E';
wwv_flow_api.g_varchar2_table(36) := '202020200A2020202020202A2F0A2020202020202474686561642E63737328226C656674222C202D2474626F64792E7363726F6C6C4C6566742829293B202F2F666978207468652074686561642072656C617469766520746F2074686520626F64792073';
wwv_flow_api.g_varchar2_table(37) := '63726F6C6C696E670A2020202020202474686561642E66696E64282774683A6E74682D6368696C6428312927292E63737328226C656674222C202474626F64792E7363726F6C6C4C6566742829293B202F2F666978207468652066697273742063656C6C';
wwv_flow_api.g_varchar2_table(38) := '206F6620746865206865616465720A2020202020202474626F64792E66696E64282774643A6E74682D6368696C6428312927292E63737328226C656674222C202474626F64792E7363726F6C6C4C6566742829293B202F2F666978207468652066697273';
wwv_flow_api.g_varchar2_table(39) := '7420636F6C756D6E206F6620626F647920287468697320636F6C756D6E206973202266726F7A656E22290A202020207D293B0A0A20207D3B0A0A7D292820696E73756D546B2E667265657A65722C20617065782E6A517565727920293B0A0A2F2F232073';
wwv_flow_api.g_varchar2_table(40) := '6F757263654D617070696E6755524C3D6A6D725F667265657A655F6865616465725F636F6C756D6E2E6A732E6D61700A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(367123025904864575)
,p_plugin_id=>wwv_flow_api.id(367061745204508505)
,p_file_name=>'jmr_freeze_header_column.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
