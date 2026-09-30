package com.functionhall.dao;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.*;

@Repository
public class HallDao {

    private final String url;
    private final String username;
    private final String password;

    public HallDao(
            @Value("${spring.datasource.url}") String url,
            @Value("${spring.datasource.username}") String username,
            @Value("${spring.datasource.password}") String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public List<Map<String, Object>> findAll() throws SQLException {
        String sql = "SELECT hall_id, hall_name, location, capacity, hall_price, description, available FROM halls ORDER BY hall_id";
        List<Map<String, Object>> halls = new ArrayList<>();

        try (Connection con = DriverManager.getConnection(url, username, password);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> hall = new LinkedHashMap<>();
                hall.put("hallId", rs.getInt("hall_id"));
                hall.put("hallName", rs.getString("hall_name"));
                hall.put("location", rs.getString("location"));
                hall.put("capacity", rs.getInt("capacity"));
                hall.put("hallPrice", rs.getBigDecimal("hall_price"));
                hall.put("description", rs.getString("description"));
                hall.put("available", rs.getBoolean("available"));
                halls.add(hall);
            }
        }

        return halls;
    }
}
