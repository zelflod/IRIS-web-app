Class web.dancer Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ##class(web.dancer).body()
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

ClassMethod body() As %Status
{
  &JS<
<script type="text/javascript">
  var submitDancer = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Dancer is saved", expire: 2000};
      $$('tab2_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire:2000};
    webix.message(message);
  }

var menu_data = [
	{id: "tab1", icon: "mdi mdi-table", value:"Dancers list"},
	{id: "tab2", icon: "mdi mdi-pencil", value:"Create dancer"},
];

var onDelete = () => {
  alert("delete")
};

var dancer_list_template = {
  id:"tab1_content",
  view:"list",
  template:"<div style='padding-left:18px'> Name:#name#, Birthday:#birthday#, Level:#level#  </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,  
  url:"/api_cup/dancers/list",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/api_cup/dancers/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
            return false; // blocks the default click behavior
        }
    }
  };

function formatDateNum(num) {
	if (num > 0 && num < 9) {
		return '0' + num;
	}
	return num;
}

function formatDate(date) {
	const d = new Date(date);
	let m = d.getMonth() + 1;
	m = formatDateNum(m);
	const day = formatDateNum(d.getDate());

	return `${day}.${m}.${d.getFullYear()}`;
}

var dancer_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  elements:[
    {view: "text", name: "name", label: "Name"},
    //{view: "text", name: "birthday", label: "Birthday"},
    {view:"datepicker", name: "birthday", align:"right",label:"Birthday"},
    {view: "text", name: "level", label: "Level"},
    { view:"button",  value:"Submit", id:"btn", click:function(){
      var values = this.getFormView().getValues();
      values.birthday = formatDate(values.birthday);

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
        { view: "label", label: "IRIS App"},
      ]
    },
    { 
      cols:[
      {
        view: "sidebar",
        data: menu_data,
        on:{
          onAfterSelect: function(id){
            $$(`${id}_content`).show();
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
