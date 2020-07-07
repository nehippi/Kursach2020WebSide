package controller;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/")) {
            request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Client customer = Client.fromRequestParameters(request);
        customer.setAsRequestAttributes(request);

        String url = determineUrl();
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String determineUrl() {
        return "/WEB-INF/view/main.jsp";
    }

    private static class Client {

        private final String code;

        private Client(String code) {
            this.code = code;
        }

        public static Client fromRequestParameters(
                HttpServletRequest request) {
            return new Client(
                    request.getParameter("code"));
        }

        public void setAsRequestAttributes(HttpServletRequest request) {
            request.setAttribute("code", code);
            try {
                String filePath = "/home/zahar/IdeaProjects/Kursach2020Serv/" + code + "ClientFile.txt";
                FileReader fr = new FileReader(filePath);
                int c;
                StringBuilder stringBuilder = new StringBuilder();
                while ((c = fr.read()) != -1) {
                    stringBuilder.append((char) c);
                }
                String notesString = stringBuilder.toString();
                String[] arr = notesString.split(",");
                ArrayList<Integer> notes = new ArrayList<>();

                for (String s : arr) {
                    if (Integer.parseInt(s) < 69 && Integer.parseInt(s) > -69) {
                        notes.add(Integer.parseInt(s));
                    }
                }

                request.setAttribute("notes", notes.toString());
            } catch (FileNotFoundException e) {
                request.setAttribute("notes", "FNFException");
                e.printStackTrace();
            } catch (IOException e) {
                request.setAttribute("notes", "IOException");
                e.printStackTrace();
            }
        }

    }

}
