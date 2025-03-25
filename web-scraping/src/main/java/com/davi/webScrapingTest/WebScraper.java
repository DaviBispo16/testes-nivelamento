package com.davi.webScrapingTest;

import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class WebScraper {
    private static final String DOWNLOAD_DIR = "downloads";
    private static final String[] TARGET_ATTACHMENTS = {"Anexo I", "Anexo II"};

    public static void main(String[] args) {
        String url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos";
        List<String> downloadedFiles = new ArrayList<>();

        try {
            new File(DOWNLOAD_DIR).mkdirs();

            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla/5.0")
                    .timeout(10000)
                    .get();

            Elements links = doc.select("a[href$=.pdf]");

            for (Element link : links) {
                String linkText = link.text().trim();
                for (String target : TARGET_ATTACHMENTS) {
                    if (linkText.contains(target)) {
                        String pdfUrl = link.absUrl("href");
                        String fileName = DOWNLOAD_DIR + File.separator +
                                target.toLowerCase().replace(" ", "_") +
                                "_" + UUID.randomUUID().toString().substring(0, 8) +
                                ".pdf";

                        if (downloadFile(pdfUrl, fileName)) {
                            downloadedFiles.add(fileName);
                        }
                        break;
                    }
                }
            }

            if (!downloadedFiles.isEmpty()) {
                String zipFileName = DOWNLOAD_DIR + File.separator + "attachments.zip";
                createZip(downloadedFiles, zipFileName);
            }

        } catch (IOException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    private static boolean downloadFile(String fileURL, String fileName) {
        try {
            System.out.println("Downloading: " + fileURL);
            FileUtils.copyURLToFile(new URL(fileURL), new File(fileName));
            return true;
        } catch (IOException e) {
            System.err.println("Failed to download: " + fileName);
            return false;
        }
    }

    private static void createZip(List<String> files, String zipFileName) {
        try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFileName))) {
            for (String filePath : files) {
                File file = new File(filePath);
                try(FileInputStream fis = new FileInputStream(file)) {
                    ZipEntry zipEntry = new ZipEntry(file.getName());
                    zos.putNextEntry(zipEntry);
                    byte[] buffer = new byte[4096];
                    int length;
                    while ((length = fis.read(buffer)) > 0) {
                        zos.write(buffer, 0, length);
                    }
                    zos.closeEntry();
                }
            }
        } catch (IOException e) {
            System.err.println("Error creating ZIP: " + e.getMessage());
        }
    }
}
