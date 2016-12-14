<my-header>
    <header>
        <h1 onclick="{ onClickTitle }">jill-trainer</h1>
        <p>ver.0.1.0</p>
    </header>


    <script>
        this.onClickTitle = function () {
            riot.route('/');
        }
    </script>


    <style scoped>
        header {
            margin-bottom: 10px;
        }

        h1 {
            text-align: center;
            cursor: pointer;
        }

        h1:hover {
            opacity: 0.8;
        }

        header p{
            text-align: right;
        }
    </style>
</my-header>