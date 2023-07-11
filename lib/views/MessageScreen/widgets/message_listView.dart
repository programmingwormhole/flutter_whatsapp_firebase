// return ListView.builder(
// padding: EdgeInsets.zero,
// itemCount: messageData.length,
// itemBuilder: (_, index) {
// final data = messageData[index];
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// if (data['type'] != 'sent')
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Padding(
// padding:
// const EdgeInsets.symmetric(
// vertical: 8.0),
// child: Container(
// constraints: BoxConstraints(
// maxWidth: size.width * .7),
// decoration: const BoxDecoration(
// color: appBarColor,
// borderRadius:
// BorderRadius.only(
// topRight:
// Radius.circular(20),
// bottomLeft:
// Radius.circular(20),
// bottomRight:
// Radius.circular(20),
// )),
// child: Padding(
// padding: const EdgeInsets
//     .symmetric(
// horizontal: 10.0,
// vertical: 10,
// ),
// child: Text(
// data['text'],
// style: const TextStyle(
// color: white,
// fontSize: 16,
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// Text(
// data['time'],
// style: TextStyle(
// color: white.withOpacity(.5)),
// )
// ],
// )
// else
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.end,
// children: [
// data['message_type'] == 'emoji'
// ? Row(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// mainAxisAlignment:
// MainAxisAlignment.end,
// children: [
// Padding(
// padding: const EdgeInsets
//     .symmetric(
// vertical: 8.0),
// child: Container(
// decoration:
// const BoxDecoration(
// color: primary,
// borderRadius:
// BorderRadius
//     .only(
// topLeft: Radius
//     .circular(
// 20),
// topRight: Radius
//     .circular(
// 20),
// bottomLeft: Radius
//     .circular(
// 20),
// // bottomRight: Radius.circular(20),
// )),
// child: Padding(
// padding:
// const EdgeInsets
//     .symmetric(
// horizontal: 10.0,
// vertical: 10,
// ),
// child: Text(
// data['text'],
// style:
// const TextStyle(
// color: white,
// fontSize: 80,
// ),
// ),
// ),
// ),
// ),
// ],
// )
//     : Row(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// mainAxisAlignment:
// MainAxisAlignment.end,
// children: [
// Padding(
// padding: const EdgeInsets
//     .symmetric(
// vertical: 8.0),
// child: Container(
// decoration:
// const BoxDecoration(
// color: primary,
// borderRadius:
// BorderRadius
//     .only(
// topLeft: Radius
//     .circular(
// 20),
// topRight: Radius
//     .circular(
// 20),
// bottomLeft: Radius
//     .circular(
// 20),
// // bottomRight: Radius.circular(20),
// )),
// child: Padding(
// padding:
// const EdgeInsets
//     .symmetric(
// horizontal: 10.0,
// vertical: 10,
// ),
// child: Text(
// data['text'],
// style:
// const TextStyle(
// color: white,
// fontSize: 16,
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// Row(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// mainAxisAlignment:
// MainAxisAlignment.end,
// children: [
// Text(
// data['time'],
// style: TextStyle(
// color: white.withOpacity(.5)),
// ),
// const SizedBox(
// width: 5,
// ),
// Image.asset(
// 'assets/images/sent.png',
// width: 30,
// color: data['status'] == 'seen'
// ? primary
//     : white.withOpacity(.5),
// )
// ],
// )
// ],
// )
// ],
// );
// });