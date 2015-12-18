class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all 
  end
  
  def summary
    
    @transactions = Transaction.select("category, sum(amount) as total").
               where("createdate > '2014-01-01'").
               group("category").order("total desc")
  end

  def month 
    today = Date.today()
    thisYear = today.year
    lastYear = thisYear - 1
    currMonth = today.month
    queryMonth =  params[:id].to_i
    if queryMonth > currMonth
      queryYear = lastYear
    else
      queryYear = thisYear
    end 
     
    @transactions = Transaction.where(
        "createdate between '#{queryYear}-?-01' and '#{queryYear}-?-31'", queryMonth,queryMonth ) 
  end

  def new
  end
 
  def show
    @transaction = Transaction.find(params[:id]) 
  end

  def create
    #render plain: params[:transaction].inspect
    @transaction = Transaction.new(params[:transaction])
    @transaction.save
    redirect_to @transaction
  end
end
