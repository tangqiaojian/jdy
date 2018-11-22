package com.fh.entity.yhkd;

import java.util.List;

public class ReqData {

	private MsgHead msghead;

	private OrderBody orderbody;

	private List<OrderList> orderlist;

	public MsgHead getMsghead() {
		return msghead;
	}

	public void setMsghead(MsgHead msghead) {
		this.msghead = msghead;
	}


	public List<OrderList> getOrderlist() {
		return orderlist;
	}

	public void setOrderlist(List<OrderList> orderlist) {
		this.orderlist = orderlist;
	}

	public OrderBody getOrderbody() {
		return orderbody;
	}

	public void setOrderbody(OrderBody orderbody) {
		this.orderbody = orderbody;
	}

}
