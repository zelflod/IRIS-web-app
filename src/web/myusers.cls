Class web.myusers Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    write "<HTML>"
    do ..header()
        write "<BODY>"
        write "hello world!"
        write "</BODY>"
    write "</HTML>"
    quit $$$OK
}

ClassMethod header() As %Status
{
    &HTML<

    <HEAD>
        <script type="text/javascript" language="javascript">
        window.onload = () => {
            fetch('/api/users/get')
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    console.log(data);
                    data && data.map(item => {
                        document.write(item.name + " is " + item.age + " years");
                    });
                    
                });
        }
        </script>
    </HEAD>
    >
}

}
