<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.ArrayList" %>

<%
  ArrayList<ArrayList<String>> categories = (ArrayList<ArrayList<String>>) request.getAttribute("categories");
  String jsNameArray = "[";
  for (ArrayList<String> data: categories) {
    jsNameArray += "{name: '" + data.get(1) + "', value: '" + data.get(1) + "'}, ";
  }
  jsNameArray += "]";
%>
<html>
  <head>
    <title>ログイン</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
    <title>商品</title>
  </head>
  <body>
  <div id="app">
    <v-app>
      <%--  ツールバー読み込み　--%>
      <%@ include file="components/toolbar.jsp" %>
      <v-container fluid grid-list-xl>
        <form action="/login3_war_exploded/search" method="post">
          <v-layout wrap align-center>
            <v-flex xs12 sm6 d-flex>
              <v-select
                :items="<%=jsNameArray%>"
                item-text="name"
                item-value="value"
                v-model="selectedCategory"
                label="カテゴリーを選択してください"
                solo
              ></v-select>
            </v-flex>
          </v-layout>

          <input type="hidden" name="category" :value="selectedCategory">

          <v-layout row wrap>

            <v-flex xs12 sm6 md3>
              <v-text-field
                name="minPrice"
                label="最小値段"
              ></v-text-field>
            </v-flex>

            <v-flex xs12 sm6 md3>
              <v-text-field
                name="maxPrice"
                label="最大値段"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <v-btn type="submit" color="success">検索</v-btn>
        </form>
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
