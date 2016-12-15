<my-add-record>
    <p>{ date }</p>
    <div each="{ key, time in activityMap }" class="activity">
        <div>
            <img src="img/{ key }.jpg" data-activity="{ key }" onclick="{ onClickIcon }"/>
        </div>
        <div>
            <p>{ time }分</p>
        </div>
        <div>
            <img src="img/050.png" data-activity="{ key }" onclick="{ onClickReset }"/>
        </div>
    </div>
    <button type="button" onclick="{ onClickSave }">登録する</button>


    <script>
        self = this;
        this.date = (function () {
            var dateTime = new Date();
            return dateTime.getFullYear() + '/' + (dateTime.getMonth() + 1) + '/' + dateTime.getDate()
        })();
        this.activityMap = {
            running: 0,
            cycling: 0,
            lifting: 0,
            stretching: 0
        };
        this.configMap = opts.configMap;


        this.onClickIcon = function (event) {
            var activity = event.target.getAttribute('data-activity');
            self.activityMap[activity] += 5;
        };


        this.onClickReset = function (event) {
            var activity = event.target.getAttribute('data-activity');
            self.activityMap[activity] = 0;
        };


        this.onClickSave = function () {
            var data = self.activityMap;
            var xhr = new XMLHttpRequest();

            data.date = self.date;
            xhr.onreadystatechange = function () {
                if ((xhr.readyState === 4) && (xhr.status === 200)) {
                    riot.route('/show');
                }
            };
            xhr.open('POST', self.configMap.url + 'api/exercises', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.send(JSON.stringify(data));
        };
    </script>


    <style scoped>
        .activity {
            overflow: hidden;
            margin: 10px;
        }

        .activity > div {
            float: left;
        }

        .activity > div:nth-of-type(1) {
            width: 20%;
            margin-right: 10%;
        }

        .activity > div:nth-of-type(2) {
            margin-right: 5%;
            padding-top: 20px;
            width: 40%;
        }

        .activity > div:nth-of-type(3) {
            padding-top: 15px;
            width: 10%;
        }

        .activity img {
            display: inline-block;
            max-width: 100%;
        }

        .activity p {
            font-size: 1.5rem;
        }
    </style>
</my-add-record>