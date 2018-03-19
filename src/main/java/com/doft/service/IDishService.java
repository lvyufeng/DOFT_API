package com.doft.service;

import com.doft.common.ServerResponse;
import com.doft.pojo.Dish;
import com.doft.pojo.User;
import com.doft.vo.DishDetailVo;
import com.github.pagehelper.PageInfo;

import java.util.Date;

/**
 * @author lvyufeng
 * @date 18-3-10 下午3:03
 * @classname IDishService
 */

public interface IDishService {
    ServerResponse saveOrUpdateDish(Dish dish);
    ServerResponse<String> setSaleStatus(Long dishId, Integer status);
    ServerResponse<DishDetailVo> manageDishDetail(Long dishId);
    ServerResponse<PageInfo> getDishList(int pageNum, int pageSize);
    ServerResponse<PageInfo> searchDish(String dishName,Long dishId,int pageNum,int pageSize);
    ServerResponse<DishDetailVo> getDishDetail(Long dishId);
    ServerResponse<PageInfo> getDishByKeywordDishType(String keyword,Long dishTypeId,int pageNum,int pageSize,String orderBy);
    Long addedDishCount(Date date);
}
