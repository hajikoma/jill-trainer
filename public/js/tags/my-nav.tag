<my-nav>
    <nav>
        <ul>
            <li><button type="button" onclick="{ onClickAddRecord }"
                        class="{ active : opts.dataPage === 'add' }">
                登録</button></li>
            <li><button type="button" onclick="{ onClickShowRecord }"
                        class="{ active : opts.dataPage === 'show' }">
                一覧</button></li>
        </ul>
    </nav>

    <script>
        onClickAddRecord = function () {
            riot.route('/');
        };

        onClickShowRecord = function () {
            riot.route('/show');
        };
    </script>

    <style scoped>
        :scope　{
            position: fixed;
            left: 0;
            bottom: 5px;
            width: 100%;
            max-width: 1080px;
        }

        nav {
            margin: 0 10px;
            height: 45px;
        }

        li {
            float: left;
            width: 50%;
            text-align: center;
        }

        button {
            width:95%;
        }

        .active {
            opacity: 0.6;
        }

    </style>
</my-nav>