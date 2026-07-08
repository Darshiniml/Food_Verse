package com.food_application.invoice;

import java.awt.Color;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;
import java.io.File;
import java.io.FileOutputStream;
import com.food_application.model.Order;
import com.food_application.model.OrderItem;
import com.food_application.model.Payment;
import com.food_application.model.User;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class InvoiceGenerator {

    public static void generateInvoice(

            OutputStream outputStream,

            Order order,

            User customer,

            Payment payment,

            List<OrderItem> items,

            String restaurantName)

            throws Exception {

        Document document = new Document();

        PdfWriter.getInstance(document, outputStream);

        document.open();

        Font titleFont =
                new Font(Font.HELVETICA,22,
                        Font.BOLD,
                        Color.ORANGE);

        Font headingFont =
                new Font(Font.HELVETICA,13,
                        Font.BOLD);

        Font normalFont =
                new Font(Font.HELVETICA,11);

        Paragraph title =
                new Paragraph("FoodVerse",titleFont);

        title.setAlignment(Element.ALIGN_CENTER);

        document.add(title);

        document.add(new Paragraph(" "));

        Paragraph invoiceTitle =
                new Paragraph("PAYMENT INVOICE",
                        headingFont);

        invoiceTitle.setAlignment(Element.ALIGN_CENTER);

        document.add(invoiceTitle);

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Order ID : "
                        + order.getOrderId(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Customer : "
                        + customer.getName(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Restaurant : "
                        + restaurantName,
                        normalFont));

        document.add(
                new Paragraph(
                        "Address : "
                        + order.getDeliveryAddress(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Payment Method : "
                        + payment.getPaymentMethod(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Payment Status : "
                        + payment.getPaymentStatus(),
                        normalFont));

        SimpleDateFormat sdf =
                new SimpleDateFormat(
                        "dd-MM-yyyy HH:mm");

        document.add(
                new Paragraph(
                        "Date : "
                        + sdf.format(
                                order.getOrderDate()),
                        normalFont));

        document.add(new Paragraph(" "));
        document.add(
                new Paragraph(
                        "Order ID : "
                        + order.getOrderId(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Customer : "
                        + customer.getName(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Restaurant : "
                        + restaurantName,
                        normalFont));

        document.add(
                new Paragraph(
                        "Address : "
                        + order.getDeliveryAddress(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Payment Method : "
                        + payment.getPaymentMethod(),
                        normalFont));

        document.add(
                new Paragraph(
                        "Payment Status : "
                        + payment.getPaymentStatus(),
                        normalFont));

        SimpleDateFormat sdf1 =
                new SimpleDateFormat(
                        "dd-MM-yyyy HH:mm");

        document.add(
                new Paragraph(
                        "Date : "
                        + sdf1.format(
                                order.getOrderDate()),
                        normalFont));

        document.add(new Paragraph(" "));
        PdfPTable table = new PdfPTable(4);

        table.setWidthPercentage(100);

        table.setSpacingBefore(10);

        table.setWidths(new float[]{5,2,2,2});

        PdfPCell cell;

        cell = new PdfPCell(new Phrase("Food Item", headingFont));
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Qty", headingFont));
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Price", headingFont));
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Total", headingFont));
        cell.setBackgroundColor(Color.LIGHT_GRAY);
        table.addCell(cell);

        double subTotal = 0;

        for(OrderItem item : items){

            String foodName = "";

            if(item.getFoodItem()!=null){

                foodName = item.getFoodItem().getFoodName();

            }

            double price =
                    item.getSubtotal()/item.getQuantity();

            table.addCell(new Phrase(foodName,normalFont));

            table.addCell(
                    new Phrase(
                            String.valueOf(item.getQuantity()),
                            normalFont));

            table.addCell(
                    new Phrase(
                            "Rs. "
                            + String.format("%.2f",price),
                            normalFont));

            table.addCell(
                    new Phrase(
                            "Rs. "
                            + String.format("%.2f",
                                    item.getSubtotal()),
                            normalFont));

            subTotal += item.getSubtotal();

        }

        document.add(table);

        document.add(new Paragraph(" "));
        double gst = subTotal * 0.05;

        double grandTotal = subTotal + gst;

        Paragraph summaryTitle =
                new Paragraph(
                        "Payment Summary",
                        headingFont);

        summaryTitle.setSpacingBefore(15);

        document.add(summaryTitle);

        document.add(
                new Paragraph(
                        "Subtotal : Rs. "
                        + String.format("%.2f",subTotal),
                        normalFont));

        document.add(
                new Paragraph(
                        "GST (5%) : Rs. "
                        + String.format("%.2f",gst),
                        normalFont));

        document.add(
                new Paragraph(
                        "Grand Total : Rs. "
                        + String.format("%.2f",grandTotal),
                        headingFont));

        document.add(new Paragraph(" "));
        Paragraph footer =
                new Paragraph(

        "Thank you for ordering with FoodVerse!\n\nVisit Again ❤️",

        headingFont);

        footer.setAlignment(Element.ALIGN_CENTER);

        footer.setSpacingBefore(20);

        document.add(footer);

        document.close();

        }
   

    public static File generateInvoiceFile(

            Order order,

            User customer,

            Payment payment,

            List<OrderItem> items,

            String restaurantName)

            throws Exception {

        File invoiceFile = File.createTempFile(

                "FoodVerse_Invoice_" + order.getOrderId(),

                ".pdf");

        try (FileOutputStream fos = new FileOutputStream(invoiceFile)) {

            generateInvoice(

                    fos,

                    order,

                    customer,

                    payment,

                    items,

                    restaurantName);

        }

        return invoiceFile;

    }

        }