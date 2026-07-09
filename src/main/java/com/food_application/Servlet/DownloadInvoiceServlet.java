package com.food_application.Servlet;

import java.io.IOException;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/downloadInvoice")
public class DownloadInvoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String orderId =
                request.getParameter("orderId");

        response.setContentType("application/pdf");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=FoodVerse_Invoice.pdf");

        try {

            Document document = new Document();

            PdfWriter.getInstance(
                    document,
                    response.getOutputStream());

            document.open();

            Font title =
                    new Font(Font.HELVETICA,22,Font.BOLD);

            Font heading =
                    new Font(Font.HELVETICA,15,Font.BOLD);

            Font normal =
                    new Font(Font.HELVETICA,12);

            document.add(new Paragraph("FoodVerse",title));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "Invoice",heading));

            document.add(new Paragraph("----------------------------------------"));

            document.add(new Paragraph(
                    "Order ID : "+orderId,
                    normal));

            document.add(new Paragraph(
                    "Payment Status : SUCCESS",
                    normal));

            document.add(new Paragraph(
                    "Order Status : Preparing",
                    normal));

            document.add(new Paragraph(
                    "Estimated Delivery : 25-35 Minutes",
                    normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "Thank you for ordering from FoodVerse!",
                    heading));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "Powered by FoodVerse",
                    normal));

            document.close();

        }

        catch(Exception e){

            e.printStackTrace();

        }

    }

}