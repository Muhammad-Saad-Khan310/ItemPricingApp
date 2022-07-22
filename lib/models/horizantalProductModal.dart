// ignore_for_file: file_names

class HorizantalProductModal {
  final String productId;
  final String productImage;
  final String siteUrl;

  HorizantalProductModal(
      {required this.productImage,
      required this.productId,
      required this.siteUrl});
}

class HorizantalProductsList {
  final List products = [
    HorizantalProductModal(
        productId: '2',
        siteUrl: "https://www.alibaba.com",
        productImage:
            'https://brandslogos.com/wp-content/uploads/images/large/alibaba-com-logo.png'),
    HorizantalProductModal(
        productId: '3',
        siteUrl: "https://www.ebay.com",
        productImage:
            'https://mir-s3-cdn-cf.behance.net/project_modules/disp/e7ced710394183.560e42e297e35.jpg'),
    HorizantalProductModal(
        productId: '4',
        siteUrl: "https://www.amazon.com",
        productImage:
            'https://i.pinimg.com/originals/01/ca/da/01cada77a0a7d326d85b7969fe26a728.jpg'),
    HorizantalProductModal(
        productId: '1',
        siteUrl: "https://www.daraz.pk",
        productImage:
            'https://futurestartup.com/wp-content/uploads/2019/09/41822456_2633850196840163_3656768458990813184_n.jpg'),
    // HorizantalProductModal(
    //     productId: '5',
    //     siteUrl: "https://www.alibaba.com",
    //     productImage:
    //         'https://img.freepik.com/free-psd/premium-mobile-phone-screen-mockup-template_53876-81688.jpg?t=st=1650219729~exp=1650220329~hmac=f74580ff9c05fe097b71bdeeaf7ad23de326ac99d5fc2633f4ed8812d3310913&w=740'),
    // HorizantalProductModal(
    //     productId: '6',
    //     siteUrl: "https://www.alibaba.com",
    //     productImage:
    //         'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
    // HorizantalProductModal(
    //     productId: '7',
    //     siteUrl: "https://www.alibaba.com",
    //     productImage:
    //         'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
  ];
}
