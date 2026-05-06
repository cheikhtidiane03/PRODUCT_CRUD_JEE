<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.product_crud.model.Product" %>
<%@ page import="com.example.product_crud.model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Produit</title>
    <style>
        body  { font-family: Arial, sans-serif; margin: 30px; }
        h1    { color: #333; }
        label { display: block; margin-top: 12px; font-weight: bold; }
        input, select { padding: 8px; width: 300px; margin-top: 4px; border: 1px solid #ccc; border-radius: 4px; }
        button { margin-top: 20px; padding: 10px 20px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
        a      { margin-left: 10px; color: #666; }
    </style>
</head>
<body>

<%
    Product product = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    boolean isEdit = (product != null);
    String  title  = isEdit ? "Modifier le produit" : "Ajouter un produit";
%>

<h1><%= title %></h1>

<form action="products" method="post">

    <input type="hidden" name="id" value="<%= isEdit ? product.getId() : "" %>"/>

    <label>Nom du produit :</label>
    <input type="text" name="name" required
           value="<%= isEdit ? product.getName() : "" %>"/>

    <label>Prix (€) :</label>
    <input type="number" name="price" step="0.01" min="0" required
           value="<%= isEdit ? product.getPrice() : "" %>"/>

    <label>Catégorie :</label>
    <select name="categoryId" required>
        <option value="">-- Choisir une catégorie --</option>
        <% for (Category c : categories) {
            boolean selected = isEdit && (product.getCategoryId() == c.getId());
        %>
        <option value="<%= c.getId() %>" <%= selected ? "selected" : "" %>>
            <%= c.getName() %>
        </option>
        <% } %>
    </select>

    <br/>
    <button type="submit">Ajouter</button>
    <a href="products?action=list">Annuler</a>

</form>

</body>
</html>