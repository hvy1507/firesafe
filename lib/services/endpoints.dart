const endpoints = (
  authentication: (
    signIn: '/authentication/sign-in',
    signUp: '/authentication/sign-up',
    fcmRegister :'/authentication/fcm-register',
    fcmUnregister : '/authentication/fcm-unregister'
  ),
  category: (get: '/category/get',),
  country: (get: '/country',),
  favourite: (
    setFavourite: '/favourite/set-product',
    getFavourite: '/favourite/products',
  ),
  product: (
    getProductsCategory: '/product/get',
    getProduct: '/product/details',
    searchProduct: '/product/search',
  ),
  review: (
    getReview: '/review/product',
    addReview: '/review/review-product',
  ),
  role: (
    available: '/role/available',
    set: '/role/set',
  ),
  supplier: (
    register: '/supplier/register',
    editProfile: '/supplier/edit-profile',
    getProfile: '/supplier/profile',
    addProduct: '/supplier/add-product',
    editProduct: '/supplier/edit-product',
    getProducts: '/supplier/products',
    deleteProduct: '/supplier/delete-product',
  ),
  user: (
    getUserData: '/user/get',
    edit: '/user/edit-profile',
  ),
  newspaper: (
    getDetail: '/newspaper/get',
    getAll: '/newspaper/all',
    getNew: '/newspaper/new',
    getByProductCategory: '/newspaper/product-category',
    getByField: '/newspaper/field'
  )
);
