package com.functionhall.controller;

import com.functionhall.dao.HallDao;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/halls")
public class HallController {

    private final HallDao hallDao;

    public HallController(HallDao hallDao) {
        this.hallDao = hallDao;
    }

    @GetMapping
    public List<Map<String, Object>> getHalls() throws SQLException {
        return hallDao.findAll();
    }
}
