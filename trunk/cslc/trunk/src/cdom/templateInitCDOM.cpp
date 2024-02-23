//gcc has a problem with instantiating templates inside a template
//this is why we have to instantiate templates by hand
//template const RefTVec_RefCDOmRange CDOmBase::getChildren<CDOmRange>(_ECDOmType) const;
//template const RefTVec_RefCDOmExpr CDOmBase::getChildren<CDOmExpr>(_ECDOmType) const;
//template const RefTVec_RefCDOmExprLink CDOmBase::getChildren<CDOmExprLink>(_ECDOmType) const;
//template const RefTVec_RefCDOmMinTypMax CDOmBase::getChildren<CDOmMinTypMax>(_ECDOmType) const;
//template void stupidValidator<CDOmExpr>( const RefCDOmExpr&);
//template void stupidValidator<CDOmRange>( const RefCDOmRange&);
//template void stupidValidator<CDOmMinTypMax>( const RefCDOmMinTypMax&);
