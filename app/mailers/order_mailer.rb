class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "Заказ №#{@order.id}")
  end
end
