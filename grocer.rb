def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  
  while index < collection.length do 
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated = []
  index = 0
  
  while index < cart.length do
    item = find_item_by_name_in_collection(cart[index][:item], consolidated)
    if !item
      cart[index][:count] = 1
      consolidated.push(cart[index])
    else
      item[:count] += 1
    end
    
    index += 1
  end
  
  return consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  
  while index < coupons.length do
    current_coupon = coupons[index]
    item_index = check_coupon(cart, current_coupon)
    if item_index
      cart = update_cart_with_coupon(cart, current_coupon, item_index)
    end
    
    index += 1
  end
  return cart
end

def check_coupon(cart, coupon)
  index = 0
  
  while index < cart.length do
    item = cart[index]
    if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
      return index
    end
    index += 1
  end
  return false
end

def update_cart_with_coupon(cart, coupon, item_index)
  cart[item_index][:count] -= coupon[:num]
  
  cart.push(coupon_hash(coupon, cart[item_index]))
  
  return cart
end

def coupon_hash(coupon, item)
  {
    :item => "#{coupon[:item]} W/COUPON",
    :price => coupon[:cost] / coupon[:num],
    :clearance => item[:clearance],
    :count => coupon[:num]
  }
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  
  while index < cart.length do
    if cart[index][:clearance]
      cart[index][:price] *= 0.8
    end
    
    index += 1
  end
  return cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  index = 0
  total = 0.00
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  while index < cart.length do
    
    total += cart[index][:price] * cart[index][:count]
    
    index += 1
  end
  
  if total > 100
    total *= 0.9
  end
  
  return total.round(2)
end
