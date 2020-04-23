Class MyShop.Utils
{

ClassMethod SaveGoods(GoodsObj As MyShop.Goods) As %Status
{
    set obj = ##class(MyShop.Goods).%New()
    set obj.Name = GoodsObj.Name
    set obj.Price = GoodsObj.Price
    set obj.Description = GoodsObj.Description
    set result = obj.%Save()
    Return result
}

}
