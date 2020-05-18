Class web.cup Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ##class(web.cup).body()
  do ..footer()
    Quit $$$OK
}

ClassMethod header() As %Status
{
  &HTML<
  <html>
    <head>
      <script type="text/javascript" src="webix/webix.min.js" ></script>
      <link rel="stylesheet" type="text/css" href="webix/webix.min.css">
      <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
    </head>
  >

  Quit $$$OK
}

/// mostly JS on webix framework
ClassMethod body() As %Status
{
  &JS<
<script type="text/javascript">
  var submitDancer = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Dancer is saved", expire:-1};
      $$('tab2_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire:-1};
    webix.message(message);
  }

var menu_data = [
    {id: "tab1", icon: "mdi mdi-table", value:"Cups list"},
    {id: "tab2", icon: "mdi mdi-pencil", value:"Create a cup"},
  {id: "tab3", icon: "mdi mdi-pencil", value:"Add dancer to cup"},
  {id: "tab4", icon: "mdi mdi-pencil", value:"Add judge to cup"},
  {id: "tab5", icon: "mdi mdi-pencil", value:"Add score for dancer"},
];

var dancer_list_template = {
  id:"tab1_content",
  view:"list",
  template:"<div style='padding-left:18px'> Name:#name#, Birthday:#birthday#, Level:#level# </div>",
  type:{
    height:60
  },
  select:true,
  url:"/api_cup/dancers/list"
  };

// Single dancer form template
var dancer_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  elements:[
    {view: "text", name: "name", label: "Name"},
    {view: "text", name: "birthday", label: "Birthday"},
    {view: "text", name: "level", label: "Level"},
    { view:"button",  value:"Submit", id:"btn", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_cup/dancers/create", values, submitDancer);
    }}
  ]};

var top_menu_data = [
    { id:"1",value:"Dancers", href: '/csp/irisapp/web.dancer.cls'},
    { id:"2",value:"Judges", href: '/csp/irisapp/web.judge.cls'},
    { id:"3",value:"Cups", href: '/csp/irisapp/web.cup.cls'}
];
var top_menu = {
    view:"menu",
    data: top_menu_data,
    type:{
        subsign:true
    }
};
var top_toolbar = {
    view:"toolbar", elements:[
        top_menu
    ]
};

var ui_template = {
  height: '100%',
  rows: [
  top_toolbar,
    { view: "toolbar", padding:3, 
      elements: [
        { view: "button", type: "icon", icon: "mdi mdi-menu",
          width: 37, align: "left", css: "app_button", click: function(){
            $$("$sidebar1").toggle();
          }
        },
        { view: "label", label: "IRIS example web application for test purpose"},
      ]
    },
    { 
      cols:[
      {
        view: "sidebar",
        data: menu_data,
        on:{
          onAfterSelect: function(id){
            //let value = this.getItem(id).value;
            //webix.message(`Selected ${value}`);
            //$$("t1_content").setHTML(`Selected ${value}`);
            //let displayViewId = `${id}_content`;
            $$(`${id}_content`).show();
            //if (displayViewId === 'tab1_content') $$(displayViewId).refresh();
          }
        }
      },
      { id:"t1_content",
          cells:[
            dancer_list_template,
            dancer_form_template
        ]   
      }
    ]}
  ]};

webix.ready(function(){
  webix.ui(ui_template);
});




</script>
  >
  Quit $$$OK
}

ClassMethod footer() As %Status
{
  &HTML<
    </body></html>
  >
  Quit $$$OK
}

}
