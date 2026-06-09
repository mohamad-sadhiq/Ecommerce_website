package com.ecommerce.config;

import com.ecommerce.service.SettingsService;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class SettingsInitializer {

    @Autowired
    private SettingsService settingsService;

    @Autowired
    private ServletContext servletContext;

    // This annotation tells Spring Boot to run this method the moment the server starts!
    @EventListener(ApplicationReadyEvent.class)
    public void loadSettingsOnStartup() {

        // 1. Grab the permanent settings from the Database
        com.ecommerce.model.StoreSettings settings = settingsService.getSettings();

        // 2. Push them into the temporary applicationScope RAM for the JSPs to read
        settingsService.pushToFrontend(settings, servletContext);

        System.out.println("✅ SUCCESS: Store Settings & Media loaded from Database into Application Scope!");
    }
}