Class web.users Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    &HTML<
<HTML>
    <HEAD>
        <script type="text/javascript" language="javascript">
        window.onload = () => {
            const testResponse = httpRequest('/api/test').then(res => console.log(res));
            fetch('/api/users/get')
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    console.log(data);
                });
        }

        async function httpRequest(url) {
            // Шаг 1: начинаем загрузку fetch, получаем поток для чтения
            let response = await fetch(url);

            const reader = response.body.getReader();

            // Шаг 2: получаем длину содержимого ответа
            const contentLength = +response.headers.get('Content-Length');

            // Шаг 3: считываем данные:
            let receivedLength = 0; // количество байт, полученных на данный момент
            let chunks = []; // массив полученных двоичных фрагментов (составляющих тело ответа)
            while(true) {
            const {done, value} = await reader.read();

            if (done) {
                break;
            }

            chunks.push(value);
            receivedLength += value.length;

            }

            // Шаг 4: соединим фрагменты в общий типизированный массив Uint8Array
            let chunksAll = new Uint8Array(receivedLength); // (4.1)
            let position = 0;
            for(let chunk of chunks) {
            chunksAll.set(chunk, position); // (4.2)
            position += chunk.length; }

            // Шаг 5: декодируем Uint8Array обратно в строку
            let result = new TextDecoder("utf-8").decode(chunksAll);
            // Готово!
            let commits = JSON.parse(result);
            return commits;
        }
        </script>
    </HEAD>
<BODY>
hello
</BODY>
</HTML>
    >
    quit $$$OK
}

}
