// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -emit-llvm -g %s -o - | FileCheck %s

__attribute((objc_root_class)) @interface NSObject {
    id isa;
}
@end

@interface BaseClass : NSObject
{
    int i;
    unsigned flag_1 : 9;
    unsigned flag_2 : 9;
    unsigned : 1;
    unsigned flag_3 : 9;
}
@end

@implementation BaseClass
@end

// CHECK: !MDDerivedType(tag: DW_TAG_member, name: "i"
// CHECK-SAME:           line: 10
// CHECK-SAME:           baseType: ![[INT:[0-9]+]]
// CHECK-SAME:           size: 32, align: 32,
// CHECK-NOT:            offset:
// CHECK-SAME:           flags: DIFlagProtected
// CHECK: ![[INT]] = !MDBasicType(name: "int"
// CHECK: !MDDerivedType(tag: DW_TAG_member, name: "flag_1"
// CHECK-SAME:           line: 11
// CHECK-SAME:           baseType: ![[UNSIGNED:[0-9]+]]
// CHECK-SAME:           size: 9, align: 32,
// CHECK-NOT:            offset:
// CHECK-SAME:           flags: DIFlagProtected
// CHECK: ![[UNSIGNED]] = !MDBasicType(name: "unsigned int"
// CHECK: !MDDerivedType(tag: DW_TAG_member, name: "flag_2"
// CHECK-SAME:           line: 12
// CHECK-SAME:           baseType: ![[UNSIGNED]]
// CHECK-SAME:           size: 9, align: 32, offset: 1,
// CHECK-SAME:           flags: DIFlagProtected
// CHECK: !MDDerivedType(tag: DW_TAG_member, name: "flag_3"
// CHECK-SAME:           line: 14
// CHECK-SAME:           baseType: ![[UNSIGNED]]
// CHECK-SAME:           size: 9, align: 32, offset: 3,
// CHECK-SAME:           flags: DIFlagProtected
