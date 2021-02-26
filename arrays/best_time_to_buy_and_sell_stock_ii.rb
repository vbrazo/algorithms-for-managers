# You are given an array prices for which the ith element is the price
# of a given stock on day i.
#
# Find the maximum profit you can achieve. You may complete as many
# transactions as you like (i.e., buy one and sell one share of the
# stock multiple times).
#
# Note: You may not engage in multiple transactions simultaneously
# (i.e., you must sell the stock before you buy again).

#
# Approach 1: Brute Force
#
# In this case, we simply calculate the profit corresponding to all the
# possible sets of transactions and find out the maximum profit out of them.
#

def max_profit(prices)
  calculate(prices, 0)
end

def calculate(prices, s)
  return 0 if s >= prices.length

  max = 0
  start = s

  while start < prices.length
    maxprofit = 0
    i = start + 1
    while i < prices.length
      if prices[start] < prices[i]
        profit = calculate(prices, i + 1) + prices[i] - prices[start]
        maxprofit = profit if profit > maxprofit
      end
      i += 1
    end

    max = maxprofit if maxprofit > max

    start += 1
  end

  max
end

prices = [7, 1, 5, 3, 6, 4]
print(max_profit(prices))
# => 7
# Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5),
# profit = 5-1 = 4. Then buy on day 4 (price = 3) and sell on day 5
# (price = 6), profit = 6-3 = 3.

prices = [1, 2, 3, 4, 5]
print(max_profit(prices))
# => 4
# Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
# Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.

prices = [7, 6, 4, 3, 1]
print(max_profit(prices))
# => 0
# Explanation: In this case, no transaction is done, i.e.,
# max profit = 0.


#
# Approach 2: Peak Valley Approach
#

# Algorithm:
#
# Say the given array is: [7, 1, 5, 3, 6, 4].

# If we analyze the graph, we notice that the points of interest are the consecutive
# valleys and peaks. Mathematically speaking:
# Total Profit=∑(height(peak_i)-height(valley_i)).
# The key point is we need to consider every peak immediately following a valley
# to maximize the profit. In case we skip one of the peaks (trying to obtain more
# profit), we will end up losing the profit over one of the transactions leading
# to an overall lesser profit.
#
# For example, in the above case, if we skip peak_i and valley_j trying to obtain
# more profit by considering points with more difference in heights, the net profit
# obtained will always be lesser than the one obtained by including them, since C
# will always be lesser than A+B.

# Complexity Analysis

# Time complexity: O(n)
# Space complexity: O(1)

def max_profit(prices)
  i = 0
  valley = prices[0]
  peak = prices[0]
  maxprofit = 0

  while i < prices.length - 1
    i += 1 while i < prices.length - 1 && prices[i] >= prices[i + 1]

    valley = prices[i]

    i += 1 while i < prices.length - 1 && prices[i] <= prices[i + 1]

    peak = prices[i]

    maxprofit += peak - valley
  end

  maxprofit
end

prices = [7, 1, 5, 3, 6, 4]
print(max_profit(prices))
# => 7
# Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5),
# profit = 5-1 = 4. Then buy on day 4 (price = 3) and sell on day 5
# (price = 6), profit = 6-3 = 3.

prices = [1, 2, 3, 4, 5]
print(max_profit(prices))
# => 4
# Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
# Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.

prices = [7, 6, 4, 3, 1]
print(max_profit(prices))
# => 0
# Explanation: In this case, no transaction is done, i.e.,
# max profit = 0.
