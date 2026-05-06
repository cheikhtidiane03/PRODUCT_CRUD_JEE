package com.example.product_crud.servlet;

import com.example.product_crud.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            case "list":
                req.setAttribute("products",   dao.getAllProducts());
                req.setAttribute("categories", dao.getAllCategories());
                req.getRequestDispatcher("/views/product-list.jsp").forward(req, res);
                break;

            case "add":
                req.setAttribute("categories", dao.getAllCategories());
                req.setAttribute("product", null);
                req.getRequestDispatcher("/views/product-form.jsp").forward(req, res);
                break;

            case "edit":
                int editId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("product",    dao.getProductById(editId));
                req.setAttribute("categories", dao.getAllCategories());
                req.getRequestDispatcher("/views/product-form.jsp").forward(req, res);
                break;

            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                dao.deleteProduct(deleteId);
                res.sendRedirect("products?action=list");
                break;

            default:
                res.sendRedirect("products?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam     = req.getParameter("id");
        String name        = req.getParameter("name");
        double price       = Double.parseDouble(req.getParameter("price"));
        int    categoryId  = Integer.parseInt(req.getParameter("categoryId"));

        if (idParam == null || idParam.isEmpty()) {
            dao.addProduct(name, price, categoryId);
        } else {
            int id = Integer.parseInt(idParam);
            dao.updateProduct(id, name, price, categoryId);
        }

        res.sendRedirect("products?action=list");
    }
}