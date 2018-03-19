package com.doft.service.impl;

import com.doft.common.ServerResponse;
import com.doft.dao.DishTypeMapper;
import com.doft.pojo.DishType;
import com.doft.service.IDishTypeService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lvyufeng
 * @date 18-3-10 上午9:28
 * @classname IDishTypeServiceImpl
 */
@Service("iDishTypeService")
public class IDishTypeServiceImpl implements IDishTypeService {

    private Logger logger = LoggerFactory.getLogger(IDishTypeServiceImpl.class);

    @Autowired
    private DishTypeMapper dishTypeMapper;

    public ServerResponse addDishType(String typeName, String createBy){
        if (StringUtils.isBlank(typeName)){
            return ServerResponse.createByErrorMessage("添加菜品参数错误");
        }
        DishType dishType = new DishType();
        dishType.setTypeName(typeName);
        dishType.setStatus(true);//可用状态
        dishType.setCreatedBy(createBy);
        dishType.setLastUpdatedBy(createBy);
        int rowCount = dishTypeMapper.insert(dishType);
        if (rowCount > 0){
            return ServerResponse.createBySuccessMessage("添加菜品成功");
        }

        return ServerResponse.createByErrorMessage("添加菜品失败");
    }

    public ServerResponse updateDishTypeName(Long dishTypeId, String typeName,String updatedBy){
        if (dishTypeId == null || StringUtils.isBlank(typeName)){
            ServerResponse.createByErrorMessage("更新菜品参数错误");

        }

        DishType dishType = new DishType();
        dishType.setDishTypeId(dishTypeId);
        dishType.setTypeName(typeName);
        dishType.setLastUpdatedBy(updatedBy);

        int rowCount = dishTypeMapper.updateByPrimaryKeySelective(dishType);
        if (rowCount > 0){
            return ServerResponse.createBySuccessMessage("更新菜品成功");
        }
        return ServerResponse.createByErrorMessage("更新菜品失败");
    }

    public ServerResponse selectAllDishType(){
        List<DishType> DishTypeList = dishTypeMapper.selectAllDishType();
        if (CollectionUtils.isEmpty(DishTypeList)){
            logger.info("未找到菜系");

        }
        return ServerResponse.createBySuccess(DishTypeList);
    }
}
