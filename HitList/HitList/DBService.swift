//
//  DBService.swift
//  HitList
//
//  Created by Cecilia Zhang on 6/29/19.
//  Copyright © 2019 Cecilia Zhang. All rights reserved.
//

import Foundation

Class DBService {
    
    func save(name: String){
        //拿appDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //通过appDelegate拿数据库容器中的东西
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        //往entity中插入一个空的人，再设置人名
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath:"name")
        
        do{
            try managedContext.save()
            people.append(person)
        }catch let error as NSError{
            print("Could not save.\(error),\(error.userInfo)")
        }
    }
    
    func fetch(name: String) -> Array<Person> {
        
        var resultList: [Person] = Array<Person>()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            print("Error")
            return resultList
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.entity = entity
        
        let predicate = NSPredicate(format: "name + \(name)")
        request.predicate = predicate
        
        do{
            
            let peopleList = try managedContext.fetch(request)
            for person in peopleList {
                resultList.append(person)
            }
        } catch {
            fatalError("查询失败：\(error)")
        }
        return resultList
    }
    
    func change(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.entity = entity
        let predicate = NSPredicate(format: "name = \(name)")
        request.predicate = predicate
        
        do{
            let peopleList = try managedContext.fetch(request)
            for person in peopleList {
                //do something
            }
        }
        catch {
            fatalError("更改失败：\(error)")
        }
    }
    
    func delete(name: String){
        //拿appDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        //通过appDelegate拿数据库容器中的东西
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        //初始化request并把查询对象设为person，查询entity设为刚拿到的entity
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.entity = entity
        //查询条件以predicate的形式设好
        let predicate = NSPredicate(format: "name = \(name)")
        request.predicate = predicate
        
        do{
            let peopleList = try managedContext.fetch(request)
            for person in peopleList {
                managedContext.delete(person);
            }
        } catch {
            fatalError("查询失败：\(error)")
        }
    }
}

}
