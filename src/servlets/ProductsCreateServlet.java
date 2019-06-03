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

@WebServlet(name = "ProductsCreateServlet")
public class ProductsCreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // カテゴリーリストの取得

        // try{} の外でConnection, Statementを宣言
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jv3_product_search?characterEncoding=utf8&useSSL=false", "root", "root");
            st = con.createStatement();

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

            // カテゴリー一覧取得SQL
            String productSql = "SELECT p.name AS 商品名, c.name AS カテゴリー名, p.price AS 価格 FROM products p ";
            productSql += "INNER JOIN categories c ON c.id = p.category_id ";

            // 参照系SQLを実行(これが無いとrs動かない)
            rs = st.executeQuery(productSql);

            // sql出力
            System.out.println("参照するSQL: " + productSql);

            ArrayList<ArrayList<String>> results = new ArrayList<ArrayList<String>>();
            while (rs.next()){
                ArrayList<String> record = new ArrayList<String>();
                record.add(rs.getString("商品名"));
                record.add(rs.getString("カテゴリー名"));
                record.add(rs.getString("価格"));
                results.add(record);
            }

            // jspに値を渡す
            request.setAttribute("results", results);

            // jspに値を渡す
            request.setAttribute("categories", categories);
            RequestDispatcher rd = request.getRequestDispatcher("/product_create.jsp");
            rd.forward(request, response);


        } catch (ClassNotFoundException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/ng.jsp");
            rd.forward(request, response);

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {

                }
            }

        }
    }
}
