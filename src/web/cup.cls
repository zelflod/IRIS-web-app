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
  var submitCup = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Cup is saved", expire:-1};
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
    {id: "tab6", icon: "mdi mdi-table", value:"Results"},
];

var cup_list_template = {
  id:"tab1_content",
  view:"list",
  template:"<div style='padding-left:18px'> Name:#name#, Level:#lvl# </div>",
  type:{
    height:60
  },
  select:true,
  url:"/api_cup/cup/list"
  };

var cup_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view: "text", name: "name", label: "Name"},
    {view: "text", name: "lvl", label: "Level"},
    { view:"button",  value:"Submit", id:"btn", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_cup/cup/create", values, submitCup);
    }}
  ]};

var addDancerToCupCallback = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Dancer is added", expire:-1};
      $$('tab3_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire:-1};
      webix.message(message);
  };

var addDancerToCupTemplate = {
  id:"tab3_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "dancer", label:"Dancer", value:1, options:"/api_cup/dancers/list", labelAlign:"right" 
    },
    {view:"select", name: "cup", label:"Cup", value:1, options:"/api_cup/cup/list", labelAlign:"right" },
    { view:"button",  value:"Submit", id:"btn2", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_cup/cup/addDancer", values, addDancerToCupCallback);
    }}
  ]
};

var addJudgeToCupCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Dancer is added", expire:-1};
    $$('tab4_content').clear();
  }
  else
    message = { type:"error", text: data.message, expire:-1};
    webix.message(message);
};

var addJudgeToCupTemplate = {
  id:"tab4_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "judge", label:"Judge", value:1, options:"/api_cup/judge/list", labelAlign:"right" 
    },
    {view:"select", name: "cup", label:"Cup", value:1, options:"/api_cup/cup/list", labelAlign:"right" },
    { view:"button",  value:"Submit", id:"btn3", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_cup/cup/addJudge", values, addJudgeToCupCallback);
    }}
  ]
};

var addScoreCallback = (rawData) => {
  let data = JSON.parse(rawData);
  let message;
  if (data.result) {
    message = { type:"success", text: "Score is added", expire:-1};
    $$('tab5_content').clear();
  }
  else
    message = { type:"error", text: data.message, expire:-1};
    webix.message(message);
};

var addScoreTemplate = {
  id:"tab5_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "cup", label:"Cup", value:1, options:"/api_cup/cup/list", labelAlign:"right" },
    {view:"select", name: "judge", label:"Judge", value:1, options:"/api_cup/judge/list", labelAlign:"right" },
    {view:"select", name: "dancer", label:"Dancer", value:1, options:"/api_cup/dancers/list", labelAlign:"right" },
    {view: "text", type: "number", name: "score", label: "Score"},
    { view:"button",  value:"Submit", id:"btn4", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_cup/cup/addScore", values, addScoreCallback);
    }}
  ]
};

var resultsTemplate = {
  id:"tab6_content",
  view: "datatable",
  width: "500",
  autoConfig:true,
    url:"/api_cup/cup/results"
};

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
            cup_list_template,
            cup_form_template,
            addDancerToCupTemplate,
            addJudgeToCupTemplate,
            addScoreTemplate,
            resultsTemplate,
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
