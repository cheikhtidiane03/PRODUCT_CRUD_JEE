<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.product_crud.model.Product" %>
<%@ page import="com.example.product_crud.model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Produits</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        h1   { color: #333; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #4CAF50; color: white; }
        tr:nth-child(even) { background: #f9f9f9; }
        a.btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; color: white; }
        .btn-add    { background: #4CAF50; }
        .btn-edit   { background: #2196F3; }
        .btn-delete { background: #f44336; }
    </style>
</head>
<body>

<h1>Liste des Produits</h1>
<a href="products?action=add" class="btn btn-add">Ajouter un produit</a>
<br/><br/>

<%
    List<Product>  products   = (List<Product>)  request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

%>

<table>
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Prix</th>
        <th>Catégorie</th>
        <th>Actions</th>
    </tr>

    <% for (Product p : products) {

        String categoryName = "Inconnue";
        for (Category c : categories) {
            if (c.getId() == p.getCategoryId()) {
                categoryName = c.getName();
                break;
            }
        }
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getName() %></td>
        <td><%= String.format("%.2f", p.getPrice()) %></td>
        <td><%= categoryName %></td>
        <td>
            <a href="products?action=edit&id=<%= p.getId() %>" class="btn btn-edit">✏Modifier</a>
            &nbsp;
            <a href="products?action=delete&id=<%= p.getId() %>" class="btn btn-delete"
               onclick="return confirm('Supprimer ce produit ?')">Supprimer</a>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>