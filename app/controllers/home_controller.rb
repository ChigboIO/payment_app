class HomeController < ApplicationController
  def index
    @products = Product.all
  end

  def cart
    @products = Product.where(id: session[:cart])
    @total_price = @products.sum(:price)
    if request.post?
      stripeToken = params['stripeToken']

      line_items = @products.map do |product|
        LineItem.new(product: product, price: product.price)
      end

      order = Order.create(total_price: @total_price, stripeToken: stripeToken, line_items: line_items)
      status = 'paid'
      result = nil

      begin
        result = Stripe::Charge.create({
          :amount => (@total_price * 100).to_i,
          :currency => "usd",
          :source => stripeToken, # obtained with Stripe.js
          :description => @products.map(&:title).join(', ')
        }, {
          :idempotency_key => "order-#{order.id}-v2"
        })
      rescue => e
        status = 'error'
        result = e.message
      end

      order.update(status: status, result: result)

      session.delete(:cart)

      redirect_to thanks_path(order)
    end
  end

  def charges

  end

  def thanks
    @order = Order.find(params[:id])
  end

  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id] unless session[:cart].include?(params[:id])
    redirect_to :back
  end

  def remove_from_cart
    session[:cart].delete_if{ |r| r == params[:id] }
    redirect_to :back
  end
end
