package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(name = "CategoriesStoreServlet")
public class CategoriesStoreServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 文字化け対策
        request.setCharacterEncoding("UTF-8");

        // htmlから受信
        String categoryName = request.getParameter("name");

        // リダイレクトファイル
        String fileName = "/management.jsp";
        String message = "";

        // 出力
        System.out.println(categoryName);

        // try{} の外でConnection, Statementを宣言
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jv3_product_search?characterEncoding=utf8&useSSL=false", "root", "root");
            st = con.createStatement();

            String insertSql = "INSERT INTO categories (name) VALUES ('" + categoryName +  "')";
            st.executeUpdate(insertSql);
            message = "ユーザー登録しました";

            // カテゴリー一覧取得SQL
            String sql = "SELECT * FROM categories;";

            // 参照系SQLを実行(これが無いとrs動かない)
            rs = st.executeQuery(sql);

            // sql出力
            System.out.println("参照するSQL: " + sql);

            ArrayList<ArrayList<String>> categories = new ArrayList<ArrayList<String>>();
            while (rs.next()){
                ArrayList<String> record = new ArrayList<String>();
                record.add(rs.getString("id"));
                record.add(rs.getString("name"));
                categories.add(record);
            }

            // jspに値を渡す
            request.setAttribute("categories", categories);
            request.setAttribute("MESSAGE", "カテゴリを作成しました");
            RequestDispatcher rd = request.getRequestDispatcher("/category_create.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
