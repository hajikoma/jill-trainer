<my-app>
    <my-header></my-header>
    <my-nav data-page="{ page }"></my-nav>
    <div id="main"></div>

    <script>
        var self = this;
        this.page = 'add';

        this.on('mount', function () {
            riot.route.base('/');
            riot.route.start(true);
        });

        riot.route('/show', function () {
            self.page = 'show';
            riot.mount('#main', 'my-show-record');
        });

        riot.route('/', function () {
            self.page = 'add';
            riot.mount('#main', 'my-add-record');
        });

        riot.route('*', function () {
            riot.mount('#main', 'my-404');
        });
    </script>


    <style>
        my-app {
            display: block;
            margin: 10px auto;
            padding: 0 10px;
            max-width: 1080px;
        }

        #main {
            overflow: hidden;
            border: solid 1px gray;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            padding: 10px;
        }
    </style>
</my-app>