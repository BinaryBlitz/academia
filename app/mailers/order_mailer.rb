class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "ZP receipt")
  end
end
