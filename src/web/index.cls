Class web.index Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ..body()
  do ..footer()
    Quit $$$OK
}

ClassMethod header() As %Status
{
  &HTML<
  <html>
    <head>
      <script type="text/javascript" src="../user/codebase/webix.min.js" ></script>
      <link rel="stylesheet" type="text/css" href="../user/codebase/webix.min.css">
      <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
    </head>
  >

  Quit $$$OK
}

ClassMethod body() As %Status
{
  &JS<
<script type="text/javascript">
  var menu_data = [
	{id: "tab1", icon: "mdi mdi-table", value:"Users list"},
	{id: "tab2", icon: "mdi mdi-pencil", value:"Forms"},
	{id: "tab3", icon: "mdi mdi-book", value:"Documentation"}
];
var grid_data = [{"id":1,"title":"The Shawshank Redemption","year":1994,"votes":678790,"rating":9.2,"rank":1},{"id":2,"title":"The Godfather","year":1972,"votes":511495,"rating":9.2,"rank":2},{"id":3,"title":"The Godfather: Part II","year":1974,"votes":319352,"rating":9,"rank":3},{"id":4,"title":"The Good, the Bad and the Ugly","year":1966,"votes":213030,"rating":8.9,"rank":4},{"id":5,"title":"My Fair Lady","year":1964,"votes":533848,"rating":8.9,"rank":5},{"id":6,"title":"12 Angry Men","year":1957,"votes":164558,"rating":8.9,"rank":6}];
var grid_data1 = new Array(...grid_data).splice(0, 3);
var grid_data2 = new Array(...grid_data).splice(3, 3);

var user_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  elements:[
    {view: "text", name: "fname", label: "Name"},
    {view: "text", name: "fage", label: "Age"},
    { view:"button",  name:"submit", value:"Submit", id:"btn"}
  ]
};
var ui_template = {
			rows: [
				{ view: "toolbar", padding:3, 
          elements: [
            { view: "button", type: "icon", icon: "mdi mdi-menu",
              width: 37, align: "left", css: "app_button", click: function(){
                $$("$sidebar1").toggle();
              }
            },
            { view: "label", label: "IRIS example web application"},
          ]
				},
				{ 
          cols:[
					{
						view: "sidebar",
						data: menu_data,
						on:{
							onAfterSelect: function(id){
                let value = this.getItem(id).value;
								//webix.message(`Selected ${value}`);
                //$$("t1_content").setHTML(`Selected ${value}`);
                $$(`${id}_content`).show();
							}
						}
					},
					{ id:"t1_content",
              cells:[
                {
                  id:"tab1_content",
                  view:"list",
                  template:"#rank#. #title# <div style='padding-left:18px'> Year:#year#, votes:#votes# </div>",
                  type:{
                    height:60
                  },
                  select:true,
                  data:grid_data
                },
                user_form_template,
                {
                  id:"tab3_content",
                  view:"list",
                  template:"#rank#. #title# <div style='padding-left:18px'> Year:#year#, votes:#votes# </div>",
                  type:{
                    height:60
                  },
                  select:true,
                  data:grid_data2
                }
            ]   
          }
				]}
			]
		};

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
