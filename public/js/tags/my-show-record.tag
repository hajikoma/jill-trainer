<my-show-record>
    <table>
        <legend>{ date.getFullYear() }年{ date.getMonth() + 1 }月</legend>
        <thead>
        <tr>
            <th></th>
            <th><img src="img/running.jpg"/></th>
            <th><img src="img/cycling.jpg"/></th>
            <th><img src="img/lifting.jpg"/></th>
            <th><img src="img/stretching.jpg"/></th>
            <th>合計</th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <td>合計</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </tfoot>
        <tbody>
        <tr each="{ data, index in exerciseData }">
            <td>{ data.date.split('/')[2] }日</td>
            <td>{ igNull(data.running) }分</td>
            <td>{ igNull(data.cycling) }分</td>
            <td>{ igNull(data.lifting) }分</td>
            <td>{ igNull(data.stretching) }分</td>
            <td>{ igNull(data.running) + igNull(data.cycling) + igNull(data.lifting) + igNull(data.stretching) }分</td>
        </tr>
        </tbody>
    </table>

    <script>
        var self = this;
        this.date = new Date();
        this.exerciseData = [];
        this.configMap = opts.configMap;


        this.on('mount', function () {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if ((xhr.readyState === 4) && (xhr.status === 200)) {
                    self.exerciseData = xhr.response;
                    riot.update();
                }
            };
            xhr.open('GET', self.configMap.url + 'api/exercises', true );
            xhr.responseType = 'json';
            xhr.send( null );
        });


        this.onClickBack = function () {
            riot.route('/');
        };


        this.igNull = function (value) {
            return Number(value) || 0;
        }
    </script>


    <style scoped>
        legend{
            padding: 5px;
            font-weight: bold;
        }

        img {
            display: inline-block;
            width: 30px;
        }

        tbody tr:nth-of-type(odd){
            background-color: aliceblue;
        }
    </style>
</my-show-record>