class SafeOutOfBounds
{
  bool safeOutOfBoundsBool(List list, int index)
  {
    try
    {
      if(list[index] != null)
      {
        return true;
      }  
    }
    catch(e)
    {
      return false;
    }
    return false;
  }
}