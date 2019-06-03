<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <title>Title</title>
</head>
<body>
<div id="app">
    <v-app>
        <%--  ツールバー読み込み　--%>
        <%@ include file="components/management_toolbar.jsp" %>
        <v-container fluid grid-list-xl>

        </v-container>
    </v-app>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.js"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            selectedCategory: "",
        },
        created: function() {
            console.log(this.$el.getAttribute('data-categories'))
        }
    })
</script>
</body>
</html>
