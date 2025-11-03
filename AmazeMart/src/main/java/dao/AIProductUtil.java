package dao;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONArray;
import org.json.JSONObject;

public class AIProductUtil {

    // ✅ Your real Unsplash Access Key
    private static final String UNSPLASH_ACCESS_KEY = "hktcnPhxjJPzIpvthsvI6VhKXLlP40p88Hd-TOBm-H8";

    /**
     * Fetches the first product image URL from Unsplash for the given product name.
     */
    public static String fetchProductImage(String productName) {
        try {
            String encodedQuery = URLEncoder.encode(productName, "UTF-8");
            String apiUrl = "https://api.unsplash.com/search/photos?query=" + encodedQuery
                          + "&per_page=1&orientation=landscape&client_id=" + UNSPLASH_ACCESS_KEY;

            @SuppressWarnings("deprecation")
			URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);  // Set timeout
            conn.setReadTimeout(5000);

            int status = conn.getResponseCode();

            BufferedReader reader;
            if (status > 299) {
                reader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            } else {
                reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            }

            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }
            reader.close();

            JSONObject jsonObject = new JSONObject(json.toString());

            // Check for results
            JSONArray results = jsonObject.getJSONArray("results");
            if (results.length() > 0) {
                JSONObject firstResult = results.getJSONObject(0);
                JSONObject urls = firstResult.getJSONObject("urls");
                return urls.getString("regular");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // If no result or error, fallback
        return "https://via.placeholder.com/300x200?text=Image+Not+Found";
    }

    /**
     * Returns a dummy AI price for demo purposes (can be replaced with OpenAI API).
     */
    public static String fetchPredictedPrice(String productName) {
        productName = productName.toLowerCase();
        if (productName.contains("iphone")) return "79999.0";
        if (productName.contains("samsung")) return "68999.0";
        if (productName.contains("shirt")) return "999.0";
        if (productName.contains("refrigerator")) return "28999.0";
        if (productName.contains("shoes")) return "1999.0";
        return "1499.0"; // fallback
    }
}
