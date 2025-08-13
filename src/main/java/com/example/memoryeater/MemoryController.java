package com.example.memoryeater;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MemoryController {
    private List<byte[]> memoryChunks = new ArrayList<>();

    @GetMapping({ "/", "/app", "/app/" })
    public String index(Model model) {
        model.addAttribute("allocated", getAllocatedMemoryMB());
        return "index";
    }

    @PostMapping({ "/eat", "/app/eat" })
    public String eatMemory(@RequestParam("mb") int mb, Model model) {
        memoryChunks.add(new byte[mb * 1024 * 1024]);
        model.addAttribute("allocated", getAllocatedMemoryMB());
        return "index";
    }

    @PostMapping({ "/clear", "/app/clear" })
    public String clearMemory(Model model) {
        memoryChunks.clear();
        System.gc();
        model.addAttribute("allocated", getAllocatedMemoryMB());
        return "index";
    }

    private int getAllocatedMemoryMB() {
        int total = 0;
        for (byte[] chunk : memoryChunks) {
            total += chunk.length;
        }
        return total / (1024 * 1024);
    }
}
