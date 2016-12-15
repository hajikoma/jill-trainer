<my-add-record>
    <p>{ date.getFullYear() + '年' + (date.getMonth() + 1) + '月' + date.getDate() + '日' }</p>
    <div each="{ key, time in activityMap }" class="activity">
        <div>
            <img src="img/{ key }.jpg" data-activity="{ key }" onclick="{ onClickIcon }"/>
        </div>
        <div>
            <p>{ time }分</p>
            <img src="img/50.png" data-activity="{ key }" onclick="{ onClickReset }" />
        </div>
    </div>
    <button type="button" onclick="{ onClickSave }">登録する</button>


    <script>
        self = this;
        this.date = new Date();
        this.activityMap = {
            running: 0,
            cycling: 0,
            lifting: 0,
            stretching: 0
        };


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

            data[date] = self.date;
            xhr.onreadystatechange = function() {
                if ((xhr.readyState === 4) && (xhr.status === 200)) {
                    riot.route('/show');
                }
            };
            xhr.open('POST', 'https://jill-trainer.herokuapp.com/api/exercises', true );
            xhr.setRequestHeader( 'Content-Type', 'application/json');
            xhr.send(JSON.stringify(data));
        };
    </script>


    <style scoped>
        .activity {
            overflow: hidden;
            margin: 10px;
        }

        .activity > div{
            float: left;
        }

        .activity > div:first-child{
            width: 20%;
            margin-right: 10px;
        }

        .activity img{
            display: inline-block;
            max-width: 20%;
        }
    </style>
</my-add-record>