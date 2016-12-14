<my-add-record>
    <p>{ date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate() }</p>
    <div each="{ key, time in activityMap }" class="activity">
        <div>
            <img src="img/{ key }.jpg" data-activity="{ key }" onclick="{ onClickIcon }"/>
        </div>
        <div>
            <p>{ key }</p>
            <p>{ time }分</p>
            <p>{ calorieMap[key] * time }カロリー</p>
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
        this.calorieMap = {
            running: 10,
            cycling: 5,
            lifting: 20,
            stretching: 1
        };


        this.onClickIcon = function (event) {
            var activity = event.target.getAttribute('data-activity');
            self.activityMap[activity] += 5;
        };


        this.onClickSave = function () {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if ((xhr.readyState === 4) && (xhr.status === 200)) {
                    riot.route('/show');
                }
            };
            xhr.open('POST', 'http://localhost:3000/api/exercises', true );
            xhr.setRequestHeader( 'Content-Type', 'application/json');
            xhr.send(JSON.stringify({date: '2016-12-04', cycling: '10'}));
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
            width: 75px;
            margin-right: 10px;
        }
    </stylescoped>
</my-add-record>