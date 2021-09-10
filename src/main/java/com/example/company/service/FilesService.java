package com.example.company.service;

import com.example.company.common.utils.DataResult;
import com.example.company.entity.Files;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 * 文件上传 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface FilesService extends IService<Files> {
    DataResult saveFile(MultipartFile file);

    void removeByIdsAndFiles(List<String> ids);
}
