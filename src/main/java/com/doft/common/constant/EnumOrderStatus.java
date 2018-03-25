package com.doft.common.constant;


/**
 * Created by Jack at 18:48 2018/3/6
 * version 1.0
 */
public enum EnumOrderStatus {

    /**
     * 订单状态
     * 1. 未付款
     * 2. 已付款
     * 3. 正在申请中
     * 4. 已处理
     * 5. 已完成
     * 6. 已取消
     */

    UNPAID(1, "UNPAID", "未付款"),
    APPLYING(2, "APPLYING", "申请中"),
    PAID(3, "PAID", "已付款"),

    DEALT(4, "DEALT", "已处理"),
    FINISHED(5, "FINISHED", "已完成"),
    CANCELLED(6, "CANCELLED", "已取消");

    private final Integer code;
    private final String enDesc;
    private final String cnDesc;

    EnumOrderStatus(Integer code, String enDesc, String cnDesc) {
        this.code = code;
        this.enDesc = enDesc;
        this.cnDesc = cnDesc;
    }

    public Integer getCode() {
        return code;
    }

    public String getEnDesc() {
        return enDesc;
    }

    public String getCnDesc() {
        return cnDesc;
    }



}
