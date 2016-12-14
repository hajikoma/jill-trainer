<my-show-record>
    <table>
        <thead>
        <tr>
            <th>{ date.getFullYear() }<br />{ date.getMonth() + 1 }</th>
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
            <td>{ data.date.split('-')[2] }</td>
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


        this.on('mount', function () {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if ((xhr.readyState === 4) && (xhr.status === 200)) {
                    self.exerciseData = xhr.response;
                    riot.update();
                }
            };
            xhr.open('GET', 'http://localhost:3000/api/exercises', true );
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
        img {
            display: inline-block;
            width: 30px;
        }
    </style>
</my-show-record>