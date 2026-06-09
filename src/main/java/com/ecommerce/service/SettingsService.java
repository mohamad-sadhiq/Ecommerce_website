package com.ecommerce.service;

import com.ecommerce.model.StoreSettings;
import com.ecommerce.repository.StoreSettingsRepository;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SettingsService {

    @Autowired
    private StoreSettingsRepository repository;

    // Grab the settings from the DB (Creates a default row if missing)
    public StoreSettings getSettings() {
        return repository.findById(1L).orElseGet(() -> repository.save(new StoreSettings()));
    }

    // Save settings and instantly push them to applicationScope so the website updates!
    public void saveSettings(StoreSettings settings, ServletContext context) {
        settings.setId(1L); // Force ID to always be 1
        repository.save(settings);
        pushToFrontend(settings, context);
    }

    // A helper method to load the DB values into the frontend HTML memory
    public void pushToFrontend(StoreSettings settings, ServletContext context) {
        context.setAttribute("showAnnouncement", settings.isShowAnnouncement());
        context.setAttribute("announcementText", settings.getAnnouncementText());
        context.setAttribute("emergencyClose", settings.isEmergencyClose());

        context.setAttribute("slide1_media", settings.getSlide1Media());
        context.setAttribute("slide1_heading", settings.getSlide1Heading());
        context.setAttribute("slide1_desc", settings.getSlide1Desc());
        context.setAttribute("slide2_media", settings.getSlide2Media());
        context.setAttribute("slide2_heading", settings.getSlide2Heading());
        context.setAttribute("slide2_desc", settings.getSlide2Desc());

        context.setAttribute("video1_url", settings.getVideo1Url());
        context.setAttribute("video1_heading", settings.getVideo1Heading());
        context.setAttribute("video2_url", settings.getVideo2Url());
        context.setAttribute("video2_heading", settings.getVideo2Heading());
        context.setAttribute("video3_url", settings.getVideo3Url());
        context.setAttribute("video3_heading", settings.getVideo3Heading());
    }
}