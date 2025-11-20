package utils;

import java.io.*;
import java.util.*;

public class FileHelper {

    // Read all lines
    public static List<String> readAll(String path) {
        List<String> lines = new ArrayList<>();
        try {
            File f = new File(path);

            if (!f.exists()) return lines;

            BufferedReader br = new BufferedReader(new FileReader(f));
            String line;

            while ((line = br.readLine()) != null) {
                lines.add(line);
            }
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lines;
    }

    // Write a single line (append)
    public static void writeLine(String path, String data) {
        try {
            File f = new File(path);

            // Ensure parent folder exists
            f.getParentFile().mkdirs();

            BufferedWriter bw = new BufferedWriter(new FileWriter(f, true));
            bw.write(data);
            bw.newLine();
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Write ALL lines (replace file)
    public static void writeAll(String path, List<String> lines) {
        try {
            File f = new File(path);

            // Ensure folder exists
            f.getParentFile().mkdirs();

            BufferedWriter bw = new BufferedWriter(new FileWriter(f, false));

            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }

            bw.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
