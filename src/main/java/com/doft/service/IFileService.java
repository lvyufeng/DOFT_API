package com.doft.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author lvyufeng
 * @date 18-3-12 下午4:12
 * @classname IFileService
 */
public interface IFileService {
    String upload(MultipartFile file, String path);
}
